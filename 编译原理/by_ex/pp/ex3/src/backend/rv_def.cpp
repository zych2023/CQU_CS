#include "backend/rv_def.h"

namespace rv {

std::string toString(rvREG r) {
    switch (r) {
        case rvREG::X0: return "zero";
        case rvREG::X1: return "ra";
        case rvREG::X2: return "sp";
        case rvREG::X3: return "gp";
        case rvREG::X4: return "tp";
        case rvREG::X5: return "t0";
        case rvREG::X6: return "t1";
        case rvREG::X7: return "t2";
        case rvREG::X8: return "s0";
        case rvREG::X9: return "s1";
        case rvREG::X10: return "a0";
        case rvREG::X11: return "a1";
        case rvREG::X12: return "a2";
        case rvREG::X13: return "a3";
        case rvREG::X14: return "a4";
        case rvREG::X15: return "a5";
        case rvREG::X16: return "a6";
        case rvREG::X17: return "a7";
        case rvREG::X18: return "s2";
        case rvREG::X19: return "s3";
        case rvREG::X20: return "s4";
        case rvREG::X21: return "s5";
        case rvREG::X22: return "s6";
        case rvREG::X23: return "s7";
        case rvREG::X24: return "s8";
        case rvREG::X25: return "s9";
        case rvREG::X26: return "s10";
        case rvREG::X27: return "s11";
        case rvREG::X28: return "t3";
        case rvREG::X29: return "t4";
        case rvREG::X30: return "t5";
        case rvREG::X31: return "t6";
        default: return "x?";
    }
}

std::string toString(rvFREG r) {
    switch (r) {
        case rvFREG::F0: return "ft0";
        case rvFREG::F1: return "ft1";
        case rvFREG::F2: return "ft2";
        case rvFREG::F3: return "ft3";
        case rvFREG::F4: return "ft4";
        case rvFREG::F5: return "ft5";
        case rvFREG::F6: return "ft6";
        case rvFREG::F7: return "ft7";
        case rvFREG::F8: return "fs0";
        case rvFREG::F9: return "fs1";
        case rvFREG::F10: return "fa0";
        case rvFREG::F11: return "fa1";
        case rvFREG::F12: return "fa2";
        case rvFREG::F13: return "fa3";
        case rvFREG::F14: return "fa4";
        case rvFREG::F15: return "fa5";
        case rvFREG::F16: return "fa6";
        case rvFREG::F17: return "fa7";
        case rvFREG::F18: return "fs2";
        case rvFREG::F19: return "fs3";
        case rvFREG::F20: return "fs4";
        case rvFREG::F21: return "fs5";
        case rvFREG::F22: return "fs6";
        case rvFREG::F23: return "fs7";
        case rvFREG::F24: return "fs8";
        case rvFREG::F25: return "fs9";
        case rvFREG::F26: return "fs10";
        case rvFREG::F27: return "fs11";
        case rvFREG::F28: return "ft8";
        case rvFREG::F29: return "ft9";
        case rvFREG::F30: return "ft10";
        case rvFREG::F31: return "ft11";
        default: return "f?";
    }
}

std::string toString(rvOPCODE r) {
    switch (r) {
        case rvOPCODE::ADD: return "add";
        case rvOPCODE::SUB: return "sub";
        case rvOPCODE::XOR: return "xor";
        case rvOPCODE::OR: return "or";
        case rvOPCODE::AND: return "and";
        case rvOPCODE::SLL: return "sll";
        case rvOPCODE::SRL: return "srl";
        case rvOPCODE::SRA: return "sra";
        case rvOPCODE::SLT: return "slt";
        case rvOPCODE::SLTU: return "sltu";
        case rvOPCODE::ADDI: return "addi";
        case rvOPCODE::XORI: return "xori";
        case rvOPCODE::ORI: return "ori";
        case rvOPCODE::ANDI: return "andi";
        case rvOPCODE::SLLI: return "slli";
        case rvOPCODE::SRLI: return "srli";
        case rvOPCODE::SRAI: return "srai";
        case rvOPCODE::SLTI: return "slti";
        case rvOPCODE::SLTIU: return "sltiu";
        case rvOPCODE::LW: return "lw";
        case rvOPCODE::SW: return "sw";
        case rvOPCODE::BEQ: return "beq";
        case rvOPCODE::BNE: return "bne";
        case rvOPCODE::BLT: return "blt";
        case rvOPCODE::BGE: return "bge";
        case rvOPCODE::BLTU: return "bltu";
        case rvOPCODE::BGEU: return "bgeu";
        case rvOPCODE::JAL: return "jal";
        case rvOPCODE::JALR: return "jalr";
        case rvOPCODE::LA: return "la";
        case rvOPCODE::LI: return "li";
        case rvOPCODE::MOV: return "mv";
        case rvOPCODE::J: return "j";
        default: return "op?";
    }
}

} // namespace rv
