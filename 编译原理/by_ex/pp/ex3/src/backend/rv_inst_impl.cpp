#include "backend/rv_inst_impl.h"

namespace rv {

std::string rv_inst::draw() const {
    std::string s = toString(op);
    if (!label.empty()) {
        s += " " + label;
        return s;
    }
    if (op == rvOPCODE::LW || op == rvOPCODE::SW) {
        s += " " + toString(rd) + ", " + std::to_string(imm) + "(" + toString(rs1) + ")";
        return s;
    }
    if (op == rvOPCODE::ADDI || op == rvOPCODE::ANDI || op == rvOPCODE::ORI || op == rvOPCODE::XORI ||
        op == rvOPCODE::SLLI || op == rvOPCODE::SRLI || op == rvOPCODE::SRAI || op == rvOPCODE::SLTI || op == rvOPCODE::SLTIU) {
        s += " " + toString(rd) + ", " + toString(rs1) + ", " + std::to_string(imm);
        return s;
    }
    s += " " + toString(rd) + ", " + toString(rs1) + ", " + toString(rs2);
    return s;
}

} // namespace rv
