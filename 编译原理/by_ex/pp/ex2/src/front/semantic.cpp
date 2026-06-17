#include"front/semantic.h"

#include<cassert>
#include<cstdlib>
#include<sstream>
#include<iomanip>
#include<limits>
#include<cmath>
#include<algorithm>

using ir::Instruction;
using ir::Function;
using ir::Operand;
using ir::Operator;
using ir::Type;

#define GET_CHILD_PTR(node, type, index) auto node = dynamic_cast<type*>(root->children[index]); assert(node);

namespace {

int parse_int_literal(const string& s) {
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

double parse_float_literal(const string& s) {
    return std::strtod(s.c_str(), nullptr);
}

string to_float_string(double v) {
    std::ostringstream oss;
    oss << std::setprecision(std::numeric_limits<float>::max_digits10) << v;
    return oss.str();
}

bool is_int_like(Type t) {
    return t == Type::Int || t == Type::IntLiteral;
}

bool is_float_like(Type t) {
    return t == Type::Float || t == Type::FloatLiteral;
}

bool is_ptr(Type t) {
    return t == Type::IntPtr || t == Type::FloatPtr;
}

Type ptr_base(Type t) {
    if (t == Type::IntPtr) {
        return Type::Int;
    }
    if (t == Type::FloatPtr) {
        return Type::Float;
    }
    return Type::null;
}

Type to_ptr(Type t) {
    if (t == Type::Int) {
        return Type::IntPtr;
    }
    if (t == Type::Float) {
        return Type::FloatPtr;
    }
    return Type::null;
}

struct ConstVal {
    Type t = Type::Int;
    int iv = 0;
    double fv = 0.0;
};

ConstVal make_int_cv(int v) {
    ConstVal cv;
    cv.t = Type::Int;
    cv.iv = v;
    cv.fv = static_cast<double>(v);
    return cv;
}

ConstVal make_float_cv(double v) {
    ConstVal cv;
    cv.t = Type::Float;
    float fv = static_cast<float>(v);
    cv.iv = static_cast<int>(fv);
    cv.fv = fv;
    return cv;
}

int cv_as_int(const ConstVal& v) {
    return v.t == Type::Float ? static_cast<int>(v.fv) : v.iv;
}

double cv_as_float(const ConstVal& v) {
    return v.t == Type::Float ? v.fv : static_cast<double>(v.iv);
}

Operand int_lit(int v) {
    return Operand(std::to_string(v), Type::IntLiteral);
}

Operand float_lit(double v) {
    return Operand(to_float_string(v), Type::FloatLiteral);
}

Operand cv_to_operand(const ConstVal& v, Type target) {
    if (target == Type::Float) {
        return float_lit(cv_as_float(v));
    }
    return int_lit(cv_as_int(v));
}

struct LValInfo {
    Operand value;
    bool assignable = true;
    bool is_array_elem = false;
    Operand arr;
    Operand off;
    Type elem_type = Type::null;
};

struct LoopCtx {
    int begin_pc = 0;
    vector<int> break_jumps;
    vector<int> continue_jumps;
};

class Builder {
public:
    explicit Builder(frontend::Analyzer& analyzer): an(analyzer), program(), cur_func(nullptr), cur_ret(Type::null), loops() {}

    ir::Program run(frontend::CompUnit* root) {
        collect_function_decls(root);
        gen_comp_unit(root);

        if (!an.g_init_inst.empty()) {
            Function ginit("__global_init", Type::null);
            for (auto* inst : an.g_init_inst) {
                ginit.addInst(inst);
            }
            ginit.addInst(new Instruction(Operand(), Operand(), Operand(), Operator::_return));
            program.addFunction(ginit);

            for (auto& fn : program.functions) {
                if (fn.name == "main") {
                    fn.InstVec.insert(fn.InstVec.begin(), new ir::CallInst(Operand("__global_init", Type::null), Operand()));
                    break;
                }
            }
        }
        return program;
    }

private:
    frontend::Analyzer& an;
    ir::Program program;
    Function* cur_func;
    Type cur_ret;
    vector<LoopCtx> loops;

    Operand new_temp(Type t) {
        return Operand("_t" + std::to_string(an.tmp_cnt++), t);
    }

    void emit(Instruction* inst) {
        if (cur_func) {
            cur_func->addInst(inst);
        }
        else {
            an.g_init_inst.push_back(inst);
        }
    }

    int pc() const {
        if (cur_func) {
            return static_cast<int>(cur_func->InstVec.size());
        }
        return static_cast<int>(an.g_init_inst.size());
    }

    Instruction* inst_at(int idx) {
        assert(cur_func);
        assert(idx >= 0 && idx < static_cast<int>(cur_func->InstVec.size()));
        return cur_func->InstVec[idx];
    }

    int emit_goto(const Operand& cond) {
        emit(new Instruction(cond, Operand(), int_lit(0), Operator::_goto));
        return pc() - 1;
    }

    int emit_goto_uncond() {
        return emit_goto(Operand());
    }

    void patch_goto(int idx, int target) {
        auto* j = inst_at(idx);
        j->des = int_lit(target - idx);
    }

    Operand cast_to(Operand src, Type target) {
        if (target == Type::Int) {
            if (src.type == Type::Int) {
                return src;
            }
            if (src.type == Type::IntLiteral) {
                return src;
            }
            if (src.type == Type::FloatLiteral) {
                return int_lit(static_cast<int>(parse_float_literal(src.name)));
            }
            if (src.type == Type::Float) {
                auto t = new_temp(Type::Int);
                emit(new Instruction(src, Operand(), t, Operator::cvt_f2i));
                return t;
            }
        }
        if (target == Type::Float) {
            if (src.type == Type::Float) {
                return src;
            }
            if (src.type == Type::FloatLiteral) {
                return src;
            }
            if (src.type == Type::IntLiteral) {
                return float_lit(static_cast<double>(parse_int_literal(src.name)));
            }
            if (src.type == Type::Int) {
                auto t = new_temp(Type::Float);
                emit(new Instruction(src, Operand(), t, Operator::cvt_i2f));
                return t;
            }
        }
        return src;
    }

    Operand assign_casted(const Operand& dst, Operand src) {
        src = cast_to(src, dst.type);
        emit(new Instruction(src, Operand(), dst, dst.type == Type::Float ? Operator::fmov : Operator::mov));
        return dst;
    }

    Operand to_bool_int(Operand src) {
        if (src.type == Type::IntLiteral) {
            return int_lit(parse_int_literal(src.name) != 0 ? 1 : 0);
        }
        if (src.type == Type::FloatLiteral) {
            return int_lit(parse_float_literal(src.name) != 0.0 ? 1 : 0);
        }
        if (src.type == Type::Int) {
            auto t = new_temp(Type::Int);
            emit(new Instruction(src, int_lit(0), t, Operator::neq));
            return t;
        }
        if (src.type == Type::Float) {
            auto tf = new_temp(Type::Float);
            emit(new Instruction(src, float_lit(0.0), tf, Operator::fneq));
            auto ti = new_temp(Type::Int);
            emit(new Instruction(tf, Operand(), ti, Operator::cvt_f2i));
            return ti;
        }
        return src;
    }

    frontend::TokenType term_token(frontend::AstNode* node) {
        auto* t = dynamic_cast<frontend::Term*>(node);
        assert(t);
        return t->token.type;
    }

    Type parse_btype(frontend::BType* bt) {
        auto* t = dynamic_cast<frontend::Term*>(bt->children[0]);
        assert(t);
        if (t->token.type == frontend::TokenType::INTTK) {
            return Type::Int;
        }
        return Type::Float;
    }

    ConstVal eval_const_exp(frontend::ConstExp* node) {
        auto* add = dynamic_cast<frontend::AddExp*>(node->children[0]);
        assert(add);
        return eval_const_add(add);
    }

    ConstVal eval_const_from_exp(frontend::Exp* node) {
        auto* add = dynamic_cast<frontend::AddExp*>(node->children[0]);
        assert(add);
        return eval_const_add(add);
    }

    ConstVal eval_const_add(frontend::AddExp* node) {
        auto* first = dynamic_cast<frontend::MulExp*>(node->children[0]);
        assert(first);
        auto cur = eval_const_mul(first);
        for (size_t i = 1; i + 1 < node->children.size(); i += 2) {
            auto op = term_token(node->children[i]);
            auto* rhs_node = dynamic_cast<frontend::MulExp*>(node->children[i + 1]);
            assert(rhs_node);
            auto rhs = eval_const_mul(rhs_node);
            bool use_float = (cur.t == Type::Float || rhs.t == Type::Float);
            if (use_float) {
                double lv = cv_as_float(cur);
                double rv = cv_as_float(rhs);
                cur = make_float_cv(op == frontend::TokenType::PLUS ? lv + rv : lv - rv);
            }
            else {
                int lv = cv_as_int(cur);
                int rv = cv_as_int(rhs);
                cur = make_int_cv(op == frontend::TokenType::PLUS ? lv + rv : lv - rv);
            }
        }
        return cur;
    }

    ConstVal eval_const_mul(frontend::MulExp* node) {
        auto* first = dynamic_cast<frontend::UnaryExp*>(node->children[0]);
        assert(first);
        auto cur = eval_const_unary(first);
        for (size_t i = 1; i + 1 < node->children.size(); i += 2) {
            auto op = term_token(node->children[i]);
            auto* rhs_node = dynamic_cast<frontend::UnaryExp*>(node->children[i + 1]);
            assert(rhs_node);
            auto rhs = eval_const_unary(rhs_node);
            bool use_float = (cur.t == Type::Float || rhs.t == Type::Float);
            if (op == frontend::TokenType::MOD) {
                cur = make_int_cv(cv_as_int(cur) % cv_as_int(rhs));
                continue;
            }
            if (use_float) {
                double lv = cv_as_float(cur);
                double rv = cv_as_float(rhs);
                if (op == frontend::TokenType::MULT) {
                    cur = make_float_cv(lv * rv);
                }
                else {
                    cur = make_float_cv(lv / rv);
                }
            }
            else {
                int lv = cv_as_int(cur);
                int rv = cv_as_int(rhs);
                if (op == frontend::TokenType::MULT) {
                    cur = make_int_cv(lv * rv);
                }
                else {
                    cur = make_int_cv(lv / rv);
                }
            }
        }
        return cur;
    }

    ConstVal eval_const_unary(frontend::UnaryExp* node) {
        if (dynamic_cast<frontend::PrimaryExp*>(node->children[0])) {
            return eval_const_primary(dynamic_cast<frontend::PrimaryExp*>(node->children[0]));
        }
        auto* uop = dynamic_cast<frontend::UnaryOp*>(node->children[0]);
        assert(uop);
        auto* rhs = dynamic_cast<frontend::UnaryExp*>(node->children[1]);
        assert(rhs);
        auto cv = eval_const_unary(rhs);
        auto op = term_token(uop->children[0]);
        if (op == frontend::TokenType::PLUS) {
            return cv;
        }
        if (op == frontend::TokenType::MINU) {
            if (cv.t == Type::Float) {
                return make_float_cv(-cv.fv);
            }
            return make_int_cv(-cv.iv);
        }
        return make_int_cv(cv_as_int(cv) == 0 ? 1 : 0);
    }

    ConstVal eval_const_primary(frontend::PrimaryExp* node) {
        if (node->children.size() == 3) {
            auto* e = dynamic_cast<frontend::Exp*>(node->children[1]);
            assert(e);
            return eval_const_from_exp(e);
        }
        if (auto* lv = dynamic_cast<frontend::LVal*>(node->children[0])) {
            auto* id = dynamic_cast<frontend::Term*>(lv->children[0]);
            assert(id && lv->children.size() == 1);
            auto op = an.symbol_table.get_operand(id->token.value);
            if (op.type == Type::IntLiteral) {
                return make_int_cv(parse_int_literal(op.name));
            }
            if (op.type == Type::FloatLiteral) {
                return make_float_cv(parse_float_literal(op.name));
            }
            assert(0 && "const expression references non-const lvalue");
        }
        auto* num = dynamic_cast<frontend::Number*>(node->children[0]);
        assert(num);
        auto* term = dynamic_cast<frontend::Term*>(num->children[0]);
        assert(term);
        if (term->token.type == frontend::TokenType::INTLTR) {
            return make_int_cv(parse_int_literal(term->token.value));
        }
        return make_float_cv(parse_float_literal(term->token.value));
    }

    vector<int> parse_dimensions(frontend::AstNode* def) {
        vector<int> dims;
        for (auto* ch : def->children) {
            if (auto* ce = dynamic_cast<frontend::ConstExp*>(ch)) {
                auto cv = eval_const_exp(ce);
                dims.push_back(cv_as_int(cv));
            }
        }
        return dims;
    }

    int flatten_len(const vector<int>& dims) {
        int m = 1;
        for (int d : dims) {
            m *= d;
        }
        return m;
    }

    void collect_init_values(frontend::AstNode* init, bool is_const, Type base_type, vector<Operand>& out) {
        auto* first = dynamic_cast<frontend::Term*>(init->children[0]);
        if (first && first->token.type == frontend::TokenType::LBRACE) {
            for (auto* ch : init->children) {
                if (dynamic_cast<frontend::InitVal*>(ch) || dynamic_cast<frontend::ConstInitVal*>(ch)) {
                    collect_init_values(ch, is_const, base_type, out);
                }
            }
            return;
        }

        if (is_const) {
            auto* civ = dynamic_cast<frontend::ConstInitVal*>(init);
            assert(civ);
            auto* ce = dynamic_cast<frontend::ConstExp*>(civ->children[0]);
            assert(ce);
            auto cv = eval_const_exp(ce);
            out.push_back(cv_to_operand(cv, base_type));
        }
        else {
            auto* iv = dynamic_cast<frontend::InitVal*>(init);
            assert(iv);
            auto* e = dynamic_cast<frontend::Exp*>(iv->children[0]);
            assert(e);
            out.push_back(cast_to(gen_exp(e), base_type));
        }
    }

    void gen_comp_unit(frontend::CompUnit* root) {
        auto* unit = root;
        while (unit) {
            auto* node = unit->children[0];
            if (auto* d = dynamic_cast<frontend::Decl*>(node)) {
                gen_decl(d);
            }
            else if (auto* f = dynamic_cast<frontend::FuncDef*>(node)) {
                gen_func_def(f);
            }
            else {
                assert(0 && "invalid CompUnit child");
            }
            if (unit->children.size() == 2) {
                unit = dynamic_cast<frontend::CompUnit*>(unit->children[1]);
            }
            else {
                unit = nullptr;
            }
        }
    }

    void collect_function_decls(frontend::CompUnit* root) {
        auto* unit = root;
        while (unit) {
            auto* node = unit->children[0];
            if (auto* f = dynamic_cast<frontend::FuncDef*>(node)) {
                auto* ftype = dynamic_cast<frontend::FuncType*>(f->children[0]);
                auto* id = dynamic_cast<frontend::Term*>(f->children[1]);
                assert(ftype && id);

                Type rt = Type::null;
                auto rettok = dynamic_cast<frontend::Term*>(ftype->children[0]);
                assert(rettok);
                if (rettok->token.type == frontend::TokenType::INTTK) {
                    rt = Type::Int;
                }
                else if (rettok->token.type == frontend::TokenType::FLOATTK) {
                    rt = Type::Float;
                }

                vector<Operand> params;
                if (f->children.size() == 6) {
                    auto* fps = dynamic_cast<frontend::FuncFParams*>(f->children[3]);
                    assert(fps);
                    parse_func_fparams(fps, false, params);
                }
                an.symbol_table.functions[id->token.value] = new Function(id->token.value, params, rt);
            }

            if (unit->children.size() == 2) {
                unit = dynamic_cast<frontend::CompUnit*>(unit->children[1]);
            }
            else {
                unit = nullptr;
            }
        }
    }

    void parse_func_fparams(frontend::FuncFParams* fps, bool define_ste, vector<Operand>& params) {
        for (auto* ch : fps->children) {
            auto* fp = dynamic_cast<frontend::FuncFParam*>(ch);
            if (!fp) {
                continue;
            }
            auto* bt = dynamic_cast<frontend::BType*>(fp->children[0]);
            auto* id = dynamic_cast<frontend::Term*>(fp->children[1]);
            assert(bt && id);
            Type base = parse_btype(bt);
            vector<int> dims;
            Type ptype = base;
            if (fp->children.size() > 2) {
                ptype = to_ptr(base);
                dims.push_back(0);
                for (auto* node : fp->children) {
                    if (auto* e = dynamic_cast<frontend::Exp*>(node)) {
                        auto cv = eval_const_from_exp(e);
                        dims.push_back(cv_as_int(cv));
                    }
                }
            }
            auto name = define_ste ? an.symbol_table.get_scoped_name(id->token.value) : id->token.value;
            Operand para(name, ptype);
            params.push_back(para);
            if (define_ste) {
                an.symbol_table.scope_stack.back().table[id->token.value] = {para, dims};
            }
        }
    }

    void gen_decl(frontend::Decl* root) {
        if (auto* cd = dynamic_cast<frontend::ConstDecl*>(root->children[0])) {
            gen_const_decl(cd);
            return;
        }
        auto* vd = dynamic_cast<frontend::VarDecl*>(root->children[0]);
        assert(vd);
        gen_var_decl(vd);
    }

    void gen_const_decl(frontend::ConstDecl* root) {
        GET_CHILD_PTR(bt, frontend::BType, 1);
        Type t = parse_btype(bt);
        for (auto* ch : root->children) {
            if (auto* def = dynamic_cast<frontend::ConstDef*>(ch)) {
                gen_const_def(def, t);
            }
        }
    }

    void gen_var_decl(frontend::VarDecl* root) {
        GET_CHILD_PTR(bt, frontend::BType, 0);
        Type t = parse_btype(bt);
        for (auto* ch : root->children) {
            if (auto* def = dynamic_cast<frontend::VarDef*>(ch)) {
                gen_var_def(def, t);
            }
        }
    }

    void gen_const_def(frontend::ConstDef* root, Type base_t) {
        auto* id = dynamic_cast<frontend::Term*>(root->children[0]);
        assert(id);
        auto dims = parse_dimensions(root);

        if (dims.empty()) {
            auto* civ = dynamic_cast<frontend::ConstInitVal*>(root->children.back());
            assert(civ);
            auto* ce = dynamic_cast<frontend::ConstExp*>(civ->children[0]);
            assert(ce);
            auto cv = eval_const_exp(ce);
            Operand literal = cv_to_operand(cv, base_t);
            an.symbol_table.scope_stack.back().table[id->token.value] = {literal, {}};
            return;
        }

        Operand arr(an.symbol_table.get_scoped_name(id->token.value), to_ptr(base_t));
        an.symbol_table.scope_stack.back().table[id->token.value] = {arr, dims};
        int len = flatten_len(dims);
        if (cur_func) {
            emit(new Instruction(int_lit(len), Operand(), arr, Operator::alloc));
        }
        else {
            program.globalVal.push_back(ir::GlobalVal(arr, len));
        }

        vector<Operand> vals;
        auto* init = dynamic_cast<frontend::ConstInitVal*>(root->children.back());
        assert(init);
        collect_init_values(init, true, base_t, vals);
        if (static_cast<int>(vals.size()) < len) {
            vals.resize(len, base_t == Type::Float ? float_lit(0.0) : int_lit(0));
        }
        for (int i = 0; i < len; ++i) {
            emit(new Instruction(arr, int_lit(i), cast_to(vals[i], base_t), Operator::store));
        }
    }

    void gen_var_def(frontend::VarDef* root, Type base_t) {
        auto* id = dynamic_cast<frontend::Term*>(root->children[0]);
        assert(id);
        auto dims = parse_dimensions(root);

        if (dims.empty()) {
            Operand var(an.symbol_table.get_scoped_name(id->token.value), base_t);
            an.symbol_table.scope_stack.back().table[id->token.value] = {var, {}};
            if (!cur_func) {
                program.globalVal.push_back(ir::GlobalVal(var));
            }

            if (!root->children.empty()) {
                auto* maybe_init = dynamic_cast<frontend::InitVal*>(root->children.back());
                if (maybe_init) {
                    vector<Operand> vals;
                    collect_init_values(maybe_init, false, base_t, vals);
                    if (!vals.empty()) {
                        assign_casted(var, vals[0]);
                    }
                }
            }
            return;
        }

        Operand arr(an.symbol_table.get_scoped_name(id->token.value), to_ptr(base_t));
        an.symbol_table.scope_stack.back().table[id->token.value] = {arr, dims};
        int len = flatten_len(dims);
        if (cur_func) {
            emit(new Instruction(int_lit(len), Operand(), arr, Operator::alloc));
        }
        else {
            program.globalVal.push_back(ir::GlobalVal(arr, len));
        }

        auto* maybe_init = dynamic_cast<frontend::InitVal*>(root->children.back());
        if (!maybe_init) {
            return;
        }
        vector<Operand> vals;
        collect_init_values(maybe_init, false, base_t, vals);
        if (static_cast<int>(vals.size()) < len) {
            vals.resize(len, base_t == Type::Float ? float_lit(0.0) : int_lit(0));
        }
        for (int i = 0; i < len; ++i) {
            emit(new Instruction(arr, int_lit(i), cast_to(vals[i], base_t), Operator::store));
        }
    }

    void gen_func_def(frontend::FuncDef* root) {
        auto* ftype = dynamic_cast<frontend::FuncType*>(root->children[0]);
        auto* id = dynamic_cast<frontend::Term*>(root->children[1]);
        assert(ftype && id);

        auto* rettok = dynamic_cast<frontend::Term*>(ftype->children[0]);
        assert(rettok);
        Type rt = Type::null;
        if (rettok->token.type == frontend::TokenType::INTTK) {
            rt = Type::Int;
        }
        else if (rettok->token.type == frontend::TokenType::FLOATTK) {
            rt = Type::Float;
        }

        vector<Operand> params;
        Function fn(id->token.value, rt);
        cur_func = &fn;
        cur_ret = rt;

        an.symbol_table.scope_stack.push_back({0, id->token.value, {}});
        if (root->children.size() == 6) {
            auto* fps = dynamic_cast<frontend::FuncFParams*>(root->children[3]);
            assert(fps);
            parse_func_fparams(fps, true, params);
        }
        fn.ParameterList = params;

        auto* blk = dynamic_cast<frontend::Block*>(root->children.back());
        assert(blk);
        gen_block(blk);

        if (fn.InstVec.empty() || fn.InstVec.back()->op != Operator::_return) {
            if (rt == Type::Int) {
                emit(new Instruction(int_lit(0), Operand(), Operand(), Operator::_return));
            }
            else if (rt == Type::Float) {
                emit(new Instruction(float_lit(0.0), Operand(), Operand(), Operator::_return));
            }
            else {
                emit(new Instruction(Operand(), Operand(), Operand(), Operator::_return));
            }
        }

        an.symbol_table.scope_stack.pop_back();
        program.addFunction(fn);
        cur_func = nullptr;
        cur_ret = Type::null;
    }

    void gen_block(frontend::Block* root) {
        an.symbol_table.add_scope(root);
        for (auto* ch : root->children) {
            if (auto* bi = dynamic_cast<frontend::BlockItem*>(ch)) {
                gen_block_item(bi);
            }
        }
        an.symbol_table.exit_scope();
    }

    void gen_block_item(frontend::BlockItem* root) {
        if (auto* d = dynamic_cast<frontend::Decl*>(root->children[0])) {
            gen_decl(d);
            return;
        }
        auto* s = dynamic_cast<frontend::Stmt*>(root->children[0]);
        assert(s);
        gen_stmt(s);
    }

    void gen_stmt(frontend::Stmt* root) {
        if (auto* b = dynamic_cast<frontend::Block*>(root->children[0])) {
            gen_block(b);
            return;
        }

        if (auto* t = dynamic_cast<frontend::Term*>(root->children[0])) {
            if (t->token.type == frontend::TokenType::IFTK) {
                auto* cond = dynamic_cast<frontend::Cond*>(root->children[2]);
                auto* then_stmt = dynamic_cast<frontend::Stmt*>(root->children[4]);
                assert(cond && then_stmt);

                auto c = to_bool_int(gen_cond(cond));
                int j_true = emit_goto(c);

                if (root->children.size() == 7) {
                    auto* else_stmt = dynamic_cast<frontend::Stmt*>(root->children[6]);
                    assert(else_stmt);
                    gen_stmt(else_stmt);
                    int j_end = emit_goto_uncond();
                    int then_pc = pc();
                    patch_goto(j_true, then_pc);
                    gen_stmt(then_stmt);
                    patch_goto(j_end, pc());
                }
                else {
                    int j_end = emit_goto_uncond();
                    int then_pc = pc();
                    patch_goto(j_true, then_pc);
                    gen_stmt(then_stmt);
                    patch_goto(j_end, pc());
                }
                return;
            }

            if (t->token.type == frontend::TokenType::WHILETK) {
                auto* cond = dynamic_cast<frontend::Cond*>(root->children[2]);
                auto* body = dynamic_cast<frontend::Stmt*>(root->children[4]);
                assert(cond && body);

                int begin = pc();
                auto c = to_bool_int(gen_cond(cond));
                int j_true = emit_goto(c);
                int j_end = emit_goto_uncond();

                loops.push_back({begin, {}, {}});
                int body_pc = pc();
                patch_goto(j_true, body_pc);
                gen_stmt(body);

                for (int idx : loops.back().continue_jumps) {
                    patch_goto(idx, begin);
                }
                emit_goto_uncond();
                patch_goto(pc() - 1, begin);

                int end_pc = pc();
                patch_goto(j_end, end_pc);
                for (int idx : loops.back().break_jumps) {
                    patch_goto(idx, end_pc);
                }
                loops.pop_back();
                return;
            }

            if (t->token.type == frontend::TokenType::BREAKTK) {
                assert(!loops.empty());
                loops.back().break_jumps.push_back(emit_goto_uncond());
                return;
            }

            if (t->token.type == frontend::TokenType::CONTINUETK) {
                assert(!loops.empty());
                loops.back().continue_jumps.push_back(emit_goto_uncond());
                return;
            }

            if (t->token.type == frontend::TokenType::RETURNTK) {
                if (root->children.size() == 2) {
                    emit(new Instruction(Operand(), Operand(), Operand(), Operator::_return));
                }
                else {
                    auto* e = dynamic_cast<frontend::Exp*>(root->children[1]);
                    assert(e);
                    auto v = cast_to(gen_exp(e), cur_ret);
                    emit(new Instruction(v, Operand(), Operand(), Operator::_return));
                }
                return;
            }

            if (t->token.type == frontend::TokenType::SEMICN) {
                return;
            }
        }

        if (root->children.size() == 4 && dynamic_cast<frontend::LVal*>(root->children[0])) {
            auto* lv = dynamic_cast<frontend::LVal*>(root->children[0]);
            auto* e = dynamic_cast<frontend::Exp*>(root->children[2]);
            assert(lv && e);
            auto info = gen_lval(lv, false);
            auto rhs = gen_exp(e);
            if (info.is_array_elem) {
                emit(new Instruction(info.arr, info.off, cast_to(rhs, info.elem_type), Operator::store));
            }
            else {
                assert(info.assignable && !is_ptr(info.value.type));
                assign_casted(info.value, rhs);
            }
            return;
        }

        if (auto* e = dynamic_cast<frontend::Exp*>(root->children[0])) {
            (void)gen_exp(e);
            return;
        }

        assert(0 && "unsupported statement form");
    }

    LValInfo gen_lval(frontend::LVal* root, bool as_rvalue) {
        auto* id = dynamic_cast<frontend::Term*>(root->children[0]);
        assert(id);
        auto ste = an.symbol_table.get_ste(id->token.value);

        if (!is_ptr(ste.operand.type)) {
            LValInfo info;
            info.value = ste.operand;
            info.assignable = !(ste.operand.type == Type::IntLiteral || ste.operand.type == Type::FloatLiteral);
            return info;
        }

        vector<Operand> indexes;
        for (size_t i = 1; i < root->children.size(); ++i) {
            auto* e = dynamic_cast<frontend::Exp*>(root->children[i]);
            if (!e) {
                continue;
            }
            indexes.push_back(cast_to(gen_exp(e), Type::Int));
        }

        Operand off = int_lit(0);
        for (size_t i = 0; i < indexes.size(); ++i) {
            int factor = 1;
            for (size_t j = i + 1; j < ste.dimension.size(); ++j) {
                factor *= ste.dimension[j];
            }
            Operand term = indexes[i];
            if (factor != 1) {
                auto t = new_temp(Type::Int);
                emit(new Instruction(term, int_lit(factor), t, Operator::mul));
                term = t;
            }
            auto sum = new_temp(Type::Int);
            emit(new Instruction(off, term, sum, Operator::add));
            off = sum;
        }

        Type elem_t = ptr_base(ste.operand.type);
        bool full_index = indexes.size() == ste.dimension.size();

        if (!full_index) {
            auto p = new_temp(ste.operand.type);
            emit(new Instruction(ste.operand, off, p, Operator::getptr));
            LValInfo info;
            info.value = p;
            info.assignable = false;
            return info;
        }

        if (as_rvalue) {
            auto v = new_temp(elem_t);
            emit(new Instruction(ste.operand, off, v, Operator::load));
            LValInfo info;
            info.value = v;
            info.assignable = false;
            return info;
        }

        LValInfo info;
        info.is_array_elem = true;
        info.arr = ste.operand;
        info.off = off;
        info.elem_type = elem_t;
        return info;
    }

    Operand gen_exp(frontend::Exp* root) {
        auto* add = dynamic_cast<frontend::AddExp*>(root->children[0]);
        assert(add);
        return gen_add_exp(add);
    }

    Operand gen_cond(frontend::Cond* root) {
        auto* lor = dynamic_cast<frontend::LOrExp*>(root->children[0]);
        assert(lor);
        return gen_lor_exp(lor);
    }

    Operand gen_add_exp(frontend::AddExp* root) {
        auto* first = dynamic_cast<frontend::MulExp*>(root->children[0]);
        assert(first);
        auto cur = gen_mul_exp(first);

        for (size_t i = 1; i + 1 < root->children.size(); i += 2) {
            auto op = term_token(root->children[i]);
            auto* rhs_node = dynamic_cast<frontend::MulExp*>(root->children[i + 1]);
            assert(rhs_node);
            auto rhs = gen_mul_exp(rhs_node);

            bool use_float = is_float_like(cur.type) || is_float_like(rhs.type);
            if (use_float) {
                auto l = cast_to(cur, Type::Float);
                auto r = cast_to(rhs, Type::Float);
                auto t = new_temp(Type::Float);
                emit(new Instruction(l, r, t, op == frontend::TokenType::PLUS ? Operator::fadd : Operator::fsub));
                cur = t;
            }
            else {
                auto l = cast_to(cur, Type::Int);
                auto r = cast_to(rhs, Type::Int);
                auto t = new_temp(Type::Int);
                emit(new Instruction(l, r, t, op == frontend::TokenType::PLUS ? Operator::add : Operator::sub));
                cur = t;
            }
        }
        return cur;
    }

    Operand gen_mul_exp(frontend::MulExp* root) {
        auto* first = dynamic_cast<frontend::UnaryExp*>(root->children[0]);
        assert(first);
        auto cur = gen_unary_exp(first);

        for (size_t i = 1; i + 1 < root->children.size(); i += 2) {
            auto op = term_token(root->children[i]);
            auto* rhs_node = dynamic_cast<frontend::UnaryExp*>(root->children[i + 1]);
            assert(rhs_node);
            auto rhs = gen_unary_exp(rhs_node);

            if (op == frontend::TokenType::MOD) {
                auto l = cast_to(cur, Type::Int);
                auto r = cast_to(rhs, Type::Int);
                auto t = new_temp(Type::Int);
                emit(new Instruction(l, r, t, Operator::mod));
                cur = t;
                continue;
            }

            bool use_float = is_float_like(cur.type) || is_float_like(rhs.type);
            if (use_float) {
                auto l = cast_to(cur, Type::Float);
                auto r = cast_to(rhs, Type::Float);
                auto t = new_temp(Type::Float);
                emit(new Instruction(l, r, t,
                    op == frontend::TokenType::MULT ? Operator::fmul : Operator::fdiv));
                cur = t;
            }
            else {
                auto l = cast_to(cur, Type::Int);
                auto r = cast_to(rhs, Type::Int);
                auto t = new_temp(Type::Int);
                emit(new Instruction(l, r, t,
                    op == frontend::TokenType::MULT ? Operator::mul : Operator::div));
                cur = t;
            }
        }
        return cur;
    }

    Operand gen_rel_exp(frontend::RelExp* root) {
        auto* first = dynamic_cast<frontend::AddExp*>(root->children[0]);
        assert(first);
        auto cur = gen_add_exp(first);

        for (size_t i = 1; i + 1 < root->children.size(); i += 2) {
            auto op = term_token(root->children[i]);
            auto* rhs_node = dynamic_cast<frontend::AddExp*>(root->children[i + 1]);
            assert(rhs_node);
            auto rhs = gen_add_exp(rhs_node);

            bool use_float = is_float_like(cur.type) || is_float_like(rhs.type);
            if (use_float) {
                auto l = cast_to(cur, Type::Float);
                auto r = cast_to(rhs, Type::Float);
                auto tf = new_temp(Type::Float);
                Operator cop = Operator::flss;
                if (op == frontend::TokenType::LEQ) cop = Operator::fleq;
                else if (op == frontend::TokenType::GTR) cop = Operator::fgtr;
                else if (op == frontend::TokenType::GEQ) cop = Operator::fgeq;
                emit(new Instruction(l, r, tf, cop));
                auto ti = new_temp(Type::Int);
                emit(new Instruction(tf, Operand(), ti, Operator::cvt_f2i));
                cur = ti;
            }
            else {
                auto l = cast_to(cur, Type::Int);
                auto r = cast_to(rhs, Type::Int);
                auto t = new_temp(Type::Int);
                Operator cop = Operator::lss;
                if (op == frontend::TokenType::LEQ) cop = Operator::leq;
                else if (op == frontend::TokenType::GTR) cop = Operator::gtr;
                else if (op == frontend::TokenType::GEQ) cop = Operator::geq;
                emit(new Instruction(l, r, t, cop));
                cur = t;
            }
        }
        return cur;
    }

    Operand gen_eq_exp(frontend::EqExp* root) {
        auto* first = dynamic_cast<frontend::RelExp*>(root->children[0]);
        assert(first);
        auto cur = gen_rel_exp(first);

        for (size_t i = 1; i + 1 < root->children.size(); i += 2) {
            auto op = term_token(root->children[i]);
            auto* rhs_node = dynamic_cast<frontend::RelExp*>(root->children[i + 1]);
            assert(rhs_node);
            auto rhs = gen_rel_exp(rhs_node);

            bool use_float = is_float_like(cur.type) || is_float_like(rhs.type);
            if (use_float) {
                auto l = cast_to(cur, Type::Float);
                auto r = cast_to(rhs, Type::Float);
                auto tf = new_temp(Type::Float);
                emit(new Instruction(l, r, tf, op == frontend::TokenType::EQL ? Operator::feq : Operator::fneq));
                auto ti = new_temp(Type::Int);
                emit(new Instruction(tf, Operand(), ti, Operator::cvt_f2i));
                cur = ti;
            }
            else {
                auto l = cast_to(cur, Type::Int);
                auto r = cast_to(rhs, Type::Int);
                auto t = new_temp(Type::Int);
                emit(new Instruction(l, r, t, op == frontend::TokenType::EQL ? Operator::eq : Operator::neq));
                cur = t;
            }
        }
        return cur;
    }

    Operand gen_land_exp(frontend::LAndExp* root) {
        auto* lhs = dynamic_cast<frontend::EqExp*>(root->children[0]);
        assert(lhs);
        auto left = to_bool_int(gen_eq_exp(lhs));
        if (root->children.size() == 1) {
            return left;
        }

        auto result = new_temp(Type::Int);
        emit(new Instruction(int_lit(0), Operand(), result, Operator::mov));
        int j_true = emit_goto(left);
        int j_end = emit_goto_uncond();
        int right_pc = pc();
        patch_goto(j_true, right_pc);

        auto* rhs = dynamic_cast<frontend::LAndExp*>(root->children[2]);
        assert(rhs);
        auto right = to_bool_int(gen_land_exp(rhs));
        emit(new Instruction(right, Operand(), result, Operator::mov));
        patch_goto(j_end, pc());
        return result;
    }

    Operand gen_lor_exp(frontend::LOrExp* root) {
        auto* lhs = dynamic_cast<frontend::LAndExp*>(root->children[0]);
        assert(lhs);
        auto left = to_bool_int(gen_land_exp(lhs));
        if (root->children.size() == 1) {
            return left;
        }

        auto result = new_temp(Type::Int);
        emit(new Instruction(int_lit(1), Operand(), result, Operator::mov));

        auto not_left = new_temp(Type::Int);
        emit(new Instruction(left, Operand(), not_left, Operator::_not));
        int j_right = emit_goto(not_left);
        int j_end = emit_goto_uncond();
        int right_pc = pc();
        patch_goto(j_right, right_pc);

        auto* rhs = dynamic_cast<frontend::LOrExp*>(root->children[2]);
        assert(rhs);
        auto right = to_bool_int(gen_lor_exp(rhs));
        emit(new Instruction(right, Operand(), result, Operator::mov));
        patch_goto(j_end, pc());
        return result;
    }

    Operand gen_number(frontend::Number* root) {
        auto* t = dynamic_cast<frontend::Term*>(root->children[0]);
        assert(t);
        if (t->token.type == frontend::TokenType::INTLTR) {
            return Operand(t->token.value, Type::IntLiteral);
        }
        return Operand(t->token.value, Type::FloatLiteral);
    }

    Operand gen_primary_exp(frontend::PrimaryExp* root) {
        if (root->children.size() == 3) {
            auto* e = dynamic_cast<frontend::Exp*>(root->children[1]);
            assert(e);
            return gen_exp(e);
        }
        if (auto* lv = dynamic_cast<frontend::LVal*>(root->children[0])) {
            return gen_lval(lv, true).value;
        }
        auto* num = dynamic_cast<frontend::Number*>(root->children[0]);
        assert(num);
        return gen_number(num);
    }

    Operand gen_unary_exp(frontend::UnaryExp* root) {
        if (auto* pe = dynamic_cast<frontend::PrimaryExp*>(root->children[0])) {
            return gen_primary_exp(pe);
        }

        if (auto* opnode = dynamic_cast<frontend::UnaryOp*>(root->children[0])) {
            auto op = term_token(opnode->children[0]);
            auto* rhs = dynamic_cast<frontend::UnaryExp*>(root->children[1]);
            assert(rhs);
            auto v = gen_unary_exp(rhs);

            if (op == frontend::TokenType::PLUS) {
                return v;
            }
            if (op == frontend::TokenType::MINU) {
                if (is_float_like(v.type)) {
                    auto t = new_temp(Type::Float);
                    emit(new Instruction(float_lit(0.0), cast_to(v, Type::Float), t, Operator::fsub));
                    return t;
                }
                auto t = new_temp(Type::Int);
                emit(new Instruction(int_lit(0), cast_to(v, Type::Int), t, Operator::sub));
                return t;
            }
            auto b = to_bool_int(v);
            auto t = new_temp(Type::Int);
            emit(new Instruction(b, Operand(), t, Operator::_not));
            return t;
        }

        auto* fname = dynamic_cast<frontend::Term*>(root->children[0]);
        assert(fname);
        auto fit = an.symbol_table.functions.find(fname->token.value);
        assert(fit != an.symbol_table.functions.end());
        auto* f = fit->second;

        vector<Operand> args;
        if (root->children.size() == 4) {
            auto* frp = dynamic_cast<frontend::FuncRParams*>(root->children[2]);
            assert(frp);
            for (auto* ch : frp->children) {
                if (auto* e = dynamic_cast<frontend::Exp*>(ch)) {
                    args.push_back(gen_exp(e));
                }
            }
        }

        for (size_t i = 0; i < args.size() && i < f->ParameterList.size(); ++i) {
            auto pt = f->ParameterList[i].type;
            if (!is_ptr(pt)) {
                args[i] = cast_to(args[i], pt);
            }
        }

        Operand des;
        if (f->returnType != Type::null) {
            des = new_temp(f->returnType);
        }
        emit(new ir::CallInst(Operand(fname->token.value, Type::null), args, des));
        return des;
    }
};

} // namespace

map<std::string,ir::Function*>* frontend::get_lib_funcs() {
    static map<std::string,ir::Function*> lib_funcs = {
        {"getint", new Function("getint", Type::Int)},
        {"getch", new Function("getch", Type::Int)},
        {"getfloat", new Function("getfloat", Type::Float)},
        {"getarray", new Function("getarray", {Operand("arr", Type::IntPtr)}, Type::Int)},
        {"getfarray", new Function("getfarray", {Operand("arr", Type::FloatPtr)}, Type::Int)},
        {"putint", new Function("putint", {Operand("i", Type::Int)}, Type::null)},
        {"putch", new Function("putch", {Operand("i", Type::Int)}, Type::null)},
        {"putfloat", new Function("putfloat", {Operand("f", Type::Float)}, Type::null)},
        {"putarray", new Function("putarray", {Operand("n", Type::Int), Operand("arr", Type::IntPtr)}, Type::null)},
        {"putfarray", new Function("putfarray", {Operand("n", Type::Int), Operand("arr", Type::FloatPtr)}, Type::null)},
    };
    return &lib_funcs;
}

void frontend::SymbolTable::add_scope(Block* node) {
    (void)node;
    if (scope_stack.empty()) {
        scope_stack.push_back({0, "", {}});
        return;
    }
    auto& parent = scope_stack.back();
    string child_name = parent.name + "_b" + std::to_string(parent.cnt++);
    scope_stack.push_back({0, child_name, {}});
}

void frontend::SymbolTable::exit_scope() {
    if (!scope_stack.empty()) {
        scope_stack.pop_back();
    }
}

string frontend::SymbolTable::get_scoped_name(string id) const {
    assert(!scope_stack.empty());
    const auto& cur = scope_stack.back();
    if (cur.name.empty()) {
        return id;
    }
    return id + "_" + cur.name;
}

Operand frontend::SymbolTable::get_operand(string id) const {
    return get_ste(id).operand;
}

frontend::STE frontend::SymbolTable::get_ste(string id) const {
    for (auto it = scope_stack.rbegin(); it != scope_stack.rend(); ++it) {
        auto found = it->table.find(id);
        if (found != it->table.end()) {
            return found->second;
        }
    }
    assert(0 && "identifier not found in symbol table");
    return STE();
}

frontend::Analyzer::Analyzer(): tmp_cnt(0), symbol_table() {
    symbol_table.functions = *get_lib_funcs();
    symbol_table.scope_stack.push_back({0, "", {}});
}

ir::Program frontend::Analyzer::get_ir_program(CompUnit* root) {
    Builder builder(*this);
    return builder.run(root);
}
