#include "backend/generator.h"

#include <cassert>
#include <cstdlib>
#include <cstring>
#include <unordered_map>
#include <unordered_set>
#include <cstdint>

namespace {

bool is_int_like(ir::Type t) {
    return t == ir::Type::Int || t == ir::Type::IntLiteral;
}

bool is_float_like(ir::Type t) {
    return t == ir::Type::Float || t == ir::Type::FloatLiteral;
}

bool is_ptr(ir::Type t) {
    return t == ir::Type::IntPtr || t == ir::Type::FloatPtr;
}

bool is_literal(ir::Type t) {
    return t == ir::Type::IntLiteral || t == ir::Type::FloatLiteral;
}

int align_to(int v, int align) {
    return (v + align - 1) / align * align;
}

int parse_int_literal(const std::string& s) {
    if (s.size() >= 2 && (s.substr(0, 2) == "0b" || s.substr(0, 2) == "0B")) {
        return std::stoi(s.substr(2), nullptr, 2);
    }
    if (s.size() >= 2 && (s.substr(0, 2) == "0x" || s.substr(0, 2) == "0X")) {
        return std::stoi(s.substr(2), nullptr, 16);
    }
    if (s.size() > 1 && s[0] == '0') {
        return std::stoi(s.substr(1), nullptr, 8);
    }
    return std::stoi(s);
}

float parse_float_literal(const std::string& s) {
    return std::strtof(s.c_str(), nullptr);
}

uint32_t float_bits(float v) {
    uint32_t u = 0;
    std::memcpy(&u, &v, sizeof(uint32_t));
    return u;
}

std::string global_label(const std::string& name) {
    return std::string("_g_") + name;
}

struct GlobalInfo {
    std::unordered_map<std::string, ir::GlobalVal> map;
};

GlobalInfo g_global;

struct FrameInfo {
    std::unordered_map<std::string, int> offsets;
    std::unordered_map<std::string, int> alloc_base;
    int frame_size = 0;
    int cursor = 8; // reserve for ra/s0
};

struct ArgLoc {
    bool is_float = false;
    bool in_reg = false;
    int reg_index = 0;
    int stack_offset = 0;
};

std::vector<ArgLoc> assign_arg_locs(const std::vector<ir::Operand>& args, int& stack_bytes) {
    int int_idx = 0;
    int float_idx = 0;
    int stack_off = 0;
    std::vector<ArgLoc> locs;
    locs.reserve(args.size());
    for (const auto& arg : args) {
        ArgLoc loc;
        loc.is_float = is_float_like(arg.type);
        if (loc.is_float) {
            if (float_idx < 8) {
                loc.in_reg = true;
                loc.reg_index = float_idx++;
            } else {
                loc.in_reg = false;
                loc.stack_offset = stack_off;
                stack_off += 4;
            }
        } else {
            if (int_idx < 8) {
                loc.in_reg = true;
                loc.reg_index = int_idx++;
            } else {
                loc.in_reg = false;
                loc.stack_offset = stack_off;
                stack_off += 4;
            }
        }
        locs.push_back(loc);
    }
    stack_bytes = stack_off;
    return locs;
}

} // namespace

int backend::stackVarMap::find_operand(ir::Operand op) {
    auto it = _table.find(op.name);
    if (it == _table.end()) {
        return 0;
    }
    return it->second;
}

int backend::stackVarMap::add_operand(ir::Operand op, uint32_t size) {
    auto it = _table.find(op.name);
    if (it != _table.end()) {
        return it->second;
    }
    int next_off = 0;
    if (!_table.empty()) {
        next_off = _table.rbegin()->second;
    }
    next_off -= static_cast<int>(size);
    _table[op.name] = next_off;
    return next_off;
}

backend::Generator::Generator(ir::Program& p, std::ofstream& f) : program(p), fout(f) {}

static FrameInfo build_frame(const ir::Function& fn) {
    FrameInfo frame;
    auto add_slot = [&](const ir::Operand& op) {
        if (is_literal(op.type) || op.type == ir::Type::null) {
            return;
        }
        if (g_global.map.find(op.name) != g_global.map.end()) {
            return;
        }
        if (frame.offsets.find(op.name) != frame.offsets.end()) {
            return;
        }
        frame.cursor += 4;
        frame.offsets[op.name] = -frame.cursor;
    };

    for (const auto& p : fn.ParameterList) {
        add_slot(p);
    }

    for (const auto* inst : fn.InstVec) {
        if (inst->op != ir::Operator::call) {
            add_slot(inst->op1);
        }
        add_slot(inst->op2);
        add_slot(inst->des);

        if (inst->op == ir::Operator::alloc) {
            int count = 0;
            if (is_int_like(inst->op1.type)) {
                count = parse_int_literal(inst->op1.name);
            }
            int bytes = count * 4;
            if (bytes > 0) {
                frame.cursor += bytes;
                frame.alloc_base[inst->des.name] = -frame.cursor;
            }
        }
    }

    frame.frame_size = align_to(frame.cursor, 16);
    return frame;
}

void backend::Generator::gen() {
    g_global.map.clear();
    for (const auto& gv : program.globalVal) {
        g_global.map.emplace(gv.val.name, gv);
    }

    if (!program.globalVal.empty()) {
        fout << ".data\n";
        for (const auto& gv : program.globalVal) {
            int len = gv.maxlen > 0 ? gv.maxlen : 1;
            auto label = global_label(gv.val.name);
            fout << ".globl " << label << "\n";
            fout << label << ":\n";
            if (gv.maxlen > 0) {
                fout << "\t.zero " << (len * 4) << "\n";
            } else {
                fout << "\t.word 0\n";
            }
        }
    }

    fout << ".text\n";
    for (const auto& fn : program.functions) {
        gen_func(fn);
    }
}

void backend::Generator::gen_func(const ir::Function& fn) {
    FrameInfo frame = build_frame(fn);

    std::vector<std::string> labels;
    labels.reserve(fn.InstVec.size() + 1);
    for (size_t i = 0; i <= fn.InstVec.size(); ++i) {
        labels.push_back(".L" + fn.name + "_" + std::to_string(i));
    }
    std::string epilogue = ".L" + fn.name + "_epilogue";
    labels.back() = epilogue;

    fout << ".globl " << fn.name << "\n";
    fout << fn.name << ":\n";
    fout << "\taddi sp, sp, -" << frame.frame_size << "\n";
    fout << "\tsw ra, " << (frame.frame_size - 4) << "(sp)\n";
    fout << "\tsw s0, " << (frame.frame_size - 8) << "(sp)\n";
    fout << "\taddi s0, sp, " << frame.frame_size << "\n";

    int param_stack_bytes = 0;
    auto param_locs = assign_arg_locs(fn.ParameterList, param_stack_bytes);
    for (size_t i = 0; i < fn.ParameterList.size(); ++i) {
        const auto& p = fn.ParameterList[i];
        auto it = frame.offsets.find(p.name);
        if (it == frame.offsets.end()) {
            continue;
        }
        int off = it->second;
        const auto& loc = param_locs[i];
        if (loc.in_reg) {
            if (loc.is_float) {
                fout << "\tfsw fa" << loc.reg_index << ", " << off << "(s0)\n";
            } else {
                fout << "\tsw a" << loc.reg_index << ", " << off << "(s0)\n";
            }
        } else {
            if (loc.is_float) {
                fout << "\tflw ft0, " << loc.stack_offset << "(s0)\n";
                fout << "\tfsw ft0, " << off << "(s0)\n";
            } else {
                fout << "\tlw t0, " << loc.stack_offset << "(s0)\n";
                fout << "\tsw t0, " << off << "(s0)\n";
            }
        }
    }

    auto is_global = [](const ir::Operand& op) {
        return g_global.map.find(op.name) != g_global.map.end();
    };
    auto is_global_array = [](const ir::Operand& op) {
        auto it = g_global.map.find(op.name);
        return it != g_global.map.end() && it->second.maxlen > 0;
    };

    auto load_int = [&](const ir::Operand& op, const std::string& rd) {
        if (op.type == ir::Type::IntLiteral) {
            fout << "\tli " << rd << ", " << parse_int_literal(op.name) << "\n";
        } else if (is_global(op)) {
            auto label = global_label(op.name);
            fout << "\tla t1, " << label << "\n";
            fout << "\tlw " << rd << ", 0(t1)\n";
        } else {
            fout << "\tlw " << rd << ", " << frame.offsets.at(op.name) << "(s0)\n";
        }
    };

    auto store_int = [&](const ir::Operand& op, const std::string& rs) {
        if (is_global(op)) {
            auto label = global_label(op.name);
            fout << "\tla t1, " << label << "\n";
            fout << "\tsw " << rs << ", 0(t1)\n";
        } else {
            fout << "\tsw " << rs << ", " << frame.offsets.at(op.name) << "(s0)\n";
        }
    };

    auto load_float = [&](const ir::Operand& op, const std::string& fd, const std::string& tmp) {
        if (op.type == ir::Type::FloatLiteral) {
            float v = parse_float_literal(op.name);
            fout << "\tli " << tmp << ", " << float_bits(v) << "\n";
            fout << "\tfmv.w.x " << fd << ", " << tmp << "\n";
        } else if (is_global(op)) {
            auto label = global_label(op.name);
            fout << "\tla t1, " << label << "\n";
            fout << "\tflw " << fd << ", 0(t1)\n";
        } else {
            fout << "\tflw " << fd << ", " << frame.offsets.at(op.name) << "(s0)\n";
        }
    };

    auto store_float = [&](const ir::Operand& op, const std::string& fs) {
        if (is_global(op)) {
            auto label = global_label(op.name);
            fout << "\tla t1, " << label << "\n";
            fout << "\tfsw " << fs << ", 0(t1)\n";
        } else {
            fout << "\tfsw " << fs << ", " << frame.offsets.at(op.name) << "(s0)\n";
        }
    };

    auto load_ptr = [&](const ir::Operand& op, const std::string& rd) {
        if (is_global_array(op)) {
            auto label = global_label(op.name);
            fout << "\tla " << rd << ", " << label << "\n";
        } else if (is_global(op)) {
            auto label = global_label(op.name);
            fout << "\tla t1, " << label << "\n";
            fout << "\tlw " << rd << ", 0(t1)\n";
        } else {
            fout << "\tlw " << rd << ", " << frame.offsets.at(op.name) << "(s0)\n";
        }
    };

    auto store_ptr = [&](const ir::Operand& op, const std::string& rs) {
        if (is_global(op)) {
            auto label = global_label(op.name);
            fout << "\tla t1, " << label << "\n";
            fout << "\tsw " << rs << ", 0(t1)\n";
        } else {
            fout << "\tsw " << rs << ", " << frame.offsets.at(op.name) << "(s0)\n";
        }
    };

    for (size_t i = 0; i < fn.InstVec.size(); ++i) {
        fout << labels[i] << ":\n";

        const auto& inst = *fn.InstVec[i];
        switch (inst.op) {
            case ir::Operator::_return:
                if (inst.op1.type != ir::Type::null) {
                    if (is_float_like(inst.op1.type)) {
                        load_float(inst.op1, "fa0", "t0");
                    } else {
                        load_int(inst.op1, "a0");
                    }
                }
                fout << "\tj " << epilogue << "\n";
                break;
            case ir::Operator::_goto: {
                int off = parse_int_literal(inst.des.name);
                int target = static_cast<int>(i) + off;
                if (inst.op1.type == ir::Type::null) {
                    fout << "\tj " << labels[target] << "\n";
                } else {
                    load_int(inst.op1, "t0");
                    fout << "\tbne t0, x0, " << labels[target] << "\n";
                }
            } break;
            case ir::Operator::call: {
                auto* callinst = dynamic_cast<const ir::CallInst*>(&inst);
                int stack_bytes = 0;
                auto arg_locs = assign_arg_locs(callinst->argumentList, stack_bytes);
                int stack_alloc = align_to(stack_bytes, 16);
                if (stack_alloc > 0) {
                    fout << "\taddi sp, sp, -" << stack_alloc << "\n";
                }
                for (size_t ai = 0; ai < callinst->argumentList.size(); ++ai) {
                    const auto& arg = callinst->argumentList[ai];
                    const auto& loc = arg_locs[ai];
                    if (loc.in_reg) {
                        if (loc.is_float) {
                            load_float(arg, "fa" + std::to_string(loc.reg_index), "t0");
                        } else {
                            load_int(arg, "a" + std::to_string(loc.reg_index));
                        }
                    } else {
                        if (loc.is_float) {
                            load_float(arg, "ft0", "t0");
                            fout << "\tfsw ft0, " << loc.stack_offset << "(sp)\n";
                        } else {
                            load_int(arg, "t0");
                            fout << "\tsw t0, " << loc.stack_offset << "(sp)\n";
                        }
                    }
                }
                fout << "\tcall " << inst.op1.name << "\n";
                if (stack_alloc > 0) {
                    fout << "\taddi sp, sp, " << stack_alloc << "\n";
                }
                if (inst.des.type != ir::Type::null) {
                    if (is_float_like(inst.des.type)) {
                        store_float(inst.des, "fa0");
                    } else {
                        store_int(inst.des, "a0");
                    }
                }
            } break;
            case ir::Operator::alloc: {
                auto it = frame.alloc_base.find(inst.des.name);
                if (it != frame.alloc_base.end()) {
                    fout << "\taddi t0, s0, " << it->second << "\n";
                    store_ptr(inst.des, "t0");
                }
            } break;
            case ir::Operator::store: {
                load_ptr(inst.op1, "t0");
                load_int(inst.op2, "t1");
                fout << "\tslli t1, t1, 2\n";
                fout << "\tadd t0, t0, t1\n";
                if (is_float_like(inst.des.type)) {
                    load_float(inst.des, "ft0", "t2");
                    fout << "\tfsw ft0, 0(t0)\n";
                } else {
                    load_int(inst.des, "t2");
                    fout << "\tsw t2, 0(t0)\n";
                }
            } break;
            case ir::Operator::load: {
                load_ptr(inst.op1, "t0");
                load_int(inst.op2, "t1");
                fout << "\tslli t1, t1, 2\n";
                fout << "\tadd t0, t0, t1\n";
                if (is_float_like(inst.des.type)) {
                    fout << "\tflw ft0, 0(t0)\n";
                    store_float(inst.des, "ft0");
                } else {
                    fout << "\tlw t2, 0(t0)\n";
                    store_int(inst.des, "t2");
                }
            } break;
            case ir::Operator::getptr: {
                load_ptr(inst.op1, "t0");
                load_int(inst.op2, "t1");
                fout << "\tslli t1, t1, 2\n";
                fout << "\tadd t0, t0, t1\n";
                store_ptr(inst.des, "t0");
            } break;
            case ir::Operator::def:
            case ir::Operator::mov: {
                if (is_ptr(inst.des.type)) {
                    load_ptr(inst.op1, "t0");
                    store_ptr(inst.des, "t0");
                } else if (is_float_like(inst.des.type)) {
                    load_float(inst.op1, "ft0", "t0");
                    store_float(inst.des, "ft0");
                } else {
                    load_int(inst.op1, "t0");
                    store_int(inst.des, "t0");
                }
            } break;
            case ir::Operator::fdef:
            case ir::Operator::fmov: {
                load_float(inst.op1, "ft0", "t0");
                store_float(inst.des, "ft0");
            } break;
            case ir::Operator::cvt_i2f: {
                load_int(inst.op1, "t0");
                fout << "\tfcvt.s.w ft0, t0\n";
                store_float(inst.des, "ft0");
            } break;
            case ir::Operator::cvt_f2i: {
                load_float(inst.op1, "ft0", "t0");
                fout << "\tfcvt.w.s t0, ft0\n";
                store_int(inst.des, "t0");
            } break;
            case ir::Operator::_not: {
                load_int(inst.op1, "t0");
                fout << "\tseqz t2, t0\n";
                store_int(inst.des, "t2");
            } break;
            case ir::Operator::add:
            case ir::Operator::sub:
            case ir::Operator::mul:
            case ir::Operator::div:
            case ir::Operator::mod:
            case ir::Operator::lss:
            case ir::Operator::leq:
            case ir::Operator::gtr:
            case ir::Operator::geq:
            case ir::Operator::eq:
            case ir::Operator::neq:
            case ir::Operator::_and:
            case ir::Operator::_or: {
                load_int(inst.op1, "t0");
                load_int(inst.op2, "t1");
                switch (inst.op) {
                    case ir::Operator::add:
                        fout << "\tadd t2, t0, t1\n";
                        break;
                    case ir::Operator::sub:
                        fout << "\tsub t2, t0, t1\n";
                        break;
                    case ir::Operator::mul:
                        fout << "\tmul t2, t0, t1\n";
                        break;
                    case ir::Operator::div:
                        fout << "\tdiv t2, t0, t1\n";
                        break;
                    case ir::Operator::mod:
                        fout << "\trem t2, t0, t1\n";
                        break;
                    case ir::Operator::lss:
                        fout << "\tslt t2, t0, t1\n";
                        break;
                    case ir::Operator::gtr:
                        fout << "\tslt t2, t1, t0\n";
                        break;
                    case ir::Operator::leq:
                        fout << "\tslt t2, t1, t0\n";
                        fout << "\txori t2, t2, 1\n";
                        break;
                    case ir::Operator::geq:
                        fout << "\tslt t2, t0, t1\n";
                        fout << "\txori t2, t2, 1\n";
                        break;
                    case ir::Operator::eq:
                        fout << "\txor t2, t0, t1\n";
                        fout << "\tseqz t2, t2\n";
                        break;
                    case ir::Operator::neq:
                        fout << "\txor t2, t0, t1\n";
                        fout << "\tsnez t2, t2\n";
                        break;
                    case ir::Operator::_and:
                        fout << "\tsnez t0, t0\n";
                        fout << "\tsnez t1, t1\n";
                        fout << "\tand t2, t0, t1\n";
                        break;
                    case ir::Operator::_or:
                        fout << "\tsnez t0, t0\n";
                        fout << "\tsnez t1, t1\n";
                        fout << "\tor t2, t0, t1\n";
                        break;
                    default:
                        break;
                }
                store_int(inst.des, "t2");
            } break;
            case ir::Operator::addi:
            case ir::Operator::subi: {
                load_int(inst.op1, "t0");
                int imm = parse_int_literal(inst.op2.name);
                if (inst.op == ir::Operator::addi) {
                    fout << "\taddi t2, t0, " << imm << "\n";
                } else {
                    fout << "\taddi t2, t0, " << -imm << "\n";
                }
                store_int(inst.des, "t2");
            } break;
            case ir::Operator::fadd:
            case ir::Operator::fsub:
            case ir::Operator::fmul:
            case ir::Operator::fdiv:
            case ir::Operator::flss:
            case ir::Operator::fleq:
            case ir::Operator::fgtr:
            case ir::Operator::fgeq:
            case ir::Operator::feq:
            case ir::Operator::fneq: {
                load_float(inst.op1, "ft0", "t0");
                load_float(inst.op2, "ft1", "t0");
                switch (inst.op) {
                    case ir::Operator::fadd:
                        fout << "\tfadd.s ft2, ft0, ft1\n";
                        store_float(inst.des, "ft2");
                        break;
                    case ir::Operator::fsub:
                        fout << "\tfsub.s ft2, ft0, ft1\n";
                        store_float(inst.des, "ft2");
                        break;
                    case ir::Operator::fmul:
                        fout << "\tfmul.s ft2, ft0, ft1\n";
                        store_float(inst.des, "ft2");
                        break;
                    case ir::Operator::fdiv:
                        fout << "\tfdiv.s ft2, ft0, ft1\n";
                        store_float(inst.des, "ft2");
                        break;
                    case ir::Operator::flss:
                        fout << "\tflt.s t2, ft0, ft1\n";
                        store_int(inst.des, "t2");
                        break;
                    case ir::Operator::fleq:
                        fout << "\tfle.s t2, ft0, ft1\n";
                        store_int(inst.des, "t2");
                        break;
                    case ir::Operator::fgtr:
                        fout << "\tflt.s t2, ft1, ft0\n";
                        store_int(inst.des, "t2");
                        break;
                    case ir::Operator::fgeq:
                        fout << "\tfle.s t2, ft1, ft0\n";
                        store_int(inst.des, "t2");
                        break;
                    case ir::Operator::feq:
                        fout << "\tfeq.s t2, ft0, ft1\n";
                        store_int(inst.des, "t2");
                        break;
                    case ir::Operator::fneq:
                        fout << "\tfeq.s t2, ft0, ft1\n";
                        fout << "\txori t2, t2, 1\n";
                        store_int(inst.des, "t2");
                        break;
                    default:
                        break;
                }
            } break;
            case ir::Operator::__unuse__:
                break;
        }
    }

    fout << epilogue << ":\n";
    fout << "\tlw ra, " << (frame.frame_size - 4) << "(sp)\n";
    fout << "\tlw s0, " << (frame.frame_size - 8) << "(sp)\n";
    fout << "\taddi sp, sp, " << frame.frame_size << "\n";
    fout << "\tjr ra\n";
}

void backend::Generator::gen_instr(const ir::Instruction&) {}