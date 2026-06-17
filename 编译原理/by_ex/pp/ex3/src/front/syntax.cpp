#include"front/syntax.h"

#include<iostream>
#include<cassert>

using frontend::Parser;

// #define DEBUG_PARSER
#define CUR_TOKEN_IS(tk_type) (token_stream[index].type == TokenType::tk_type)
#define PARSE_TOKEN(tk_type) root->children.push_back(parseTerm(root, TokenType::tk_type))
#define PARSE(name, type) auto name = new type(root); assert(parse##type(name)); root->children.push_back(name); 


Parser::Parser(const std::vector<frontend::Token>& tokens): index(0), token_stream(tokens) {}

Parser::~Parser() {}

frontend::CompUnit* Parser::get_abstract_syntax_tree(){
    auto* root = new frontend::CompUnit();
    assert(parseCompUnit(root));
    assert(end());
    return root;
}

bool Parser::end() const {
    return index >= token_stream.size();
}

const frontend::Token& Parser::cur() const {
    assert(!end());
    return token_stream[index];
}

const frontend::Token& Parser::lookahead(uint32_t k) const {
    assert(index + k < token_stream.size());
    return token_stream[index + k];
}

bool Parser::accept(frontend::TokenType t) {
    if (!end() && token_stream[index].type == t) {
        ++index;
        return true;
    }
    return false;
}

frontend::Term* Parser::parseTerm(frontend::AstNode* parent, frontend::TokenType expected) {
    assert(!end());
    assert(token_stream[index].type == expected);
    auto* node = new frontend::Term(token_stream[index], parent);
    ++index;
    return node;
}

bool Parser::isFuncDefStart() const {
    if (end()) {
        return false;
    }
    auto t = cur().type;
    if (t != frontend::TokenType::VOIDTK && t != frontend::TokenType::INTTK && t != frontend::TokenType::FLOATTK) {
        return false;
    }
    if (index + 2 >= token_stream.size()) {
        return false;
    }
    return lookahead(1).type == frontend::TokenType::IDENFR && lookahead(2).type == frontend::TokenType::LPARENT;
}

bool Parser::isDeclStart() const {
    if (end()) {
        return false;
    }
    if (cur().type == frontend::TokenType::CONSTTK) {
        return true;
    }
    if (cur().type == frontend::TokenType::INTTK || cur().type == frontend::TokenType::FLOATTK) {
        return !isFuncDefStart();
    }
    return false;
}

bool Parser::isStmtStart() const {
    if (end()) {
        return false;
    }
    auto t = cur().type;
    if (t == frontend::TokenType::LBRACE || t == frontend::TokenType::IFTK || t == frontend::TokenType::WHILETK ||
        t == frontend::TokenType::BREAKTK || t == frontend::TokenType::CONTINUETK || t == frontend::TokenType::RETURNTK ||
        t == frontend::TokenType::SEMICN || t == frontend::TokenType::IDENFR || t == frontend::TokenType::LPARENT ||
        t == frontend::TokenType::INTLTR || t == frontend::TokenType::FLOATLTR || t == frontend::TokenType::PLUS ||
        t == frontend::TokenType::MINU || t == frontend::TokenType::NOT) {
        return true;
    }
    return false;
}

bool Parser::isLValAssignStart() const {
    if (end() || cur().type != frontend::TokenType::IDENFR) {
        return false;
    }
    uint32_t p = index + 1;
    while (p < token_stream.size() && token_stream[p].type == frontend::TokenType::LBRACK) {
        int depth = 0;
        do {
            assert(p < token_stream.size());
            if (token_stream[p].type == frontend::TokenType::LBRACK) {
                ++depth;
            }
            else if (token_stream[p].type == frontend::TokenType::RBRACK) {
                --depth;
            }
            ++p;
        } while (p < token_stream.size() && depth > 0);
        assert(depth == 0);
    }
    return p < token_stream.size() && token_stream[p].type == frontend::TokenType::ASSIGN;
}

bool Parser::parseCompUnit(frontend::CompUnit* root) {
    log(root);
    if (end()) {
        return false;
    }

    if (isDeclStart()) {
        PARSE(node, Decl);
    }
    else if (isFuncDefStart()) {
        PARSE(node, FuncDef);
    }
    else {
        assert(0 && "invalid CompUnit start");
    }

    if (!end()) {
        PARSE(next, CompUnit);
    }
    return true;
}

bool Parser::parseDecl(frontend::Decl* root) {
    log(root);
    if (CUR_TOKEN_IS(CONSTTK)) {
        PARSE(node, ConstDecl);
        return true;
    }
    if (CUR_TOKEN_IS(INTTK) || CUR_TOKEN_IS(FLOATTK)) {
        PARSE(node, VarDecl);
        return true;
    }
    return false;
}

bool Parser::parseFuncDef(frontend::FuncDef* root) {
    log(root);
    PARSE(ft, FuncType);
    PARSE_TOKEN(IDENFR);
    PARSE_TOKEN(LPARENT);
    if (!CUR_TOKEN_IS(RPARENT)) {
        PARSE(params, FuncFParams);
    }
    PARSE_TOKEN(RPARENT);
    PARSE(blk, Block);
    return true;
}

bool Parser::parseConstDecl(frontend::ConstDecl* root) {
    log(root);
    PARSE_TOKEN(CONSTTK);
    PARSE(bt, BType);
    PARSE(def, ConstDef);
    while (!end() && CUR_TOKEN_IS(COMMA)) {
        PARSE_TOKEN(COMMA);
        PARSE(def2, ConstDef);
    }
    PARSE_TOKEN(SEMICN);
    return true;
}

bool Parser::parseBType(frontend::BType* root) {
    log(root);
    if (CUR_TOKEN_IS(INTTK)) {
        PARSE_TOKEN(INTTK);
        return true;
    }
    if (CUR_TOKEN_IS(FLOATTK)) {
        PARSE_TOKEN(FLOATTK);
        return true;
    }
    return false;
}

bool Parser::parseConstDef(frontend::ConstDef* root) {
    log(root);
    PARSE_TOKEN(IDENFR);
    while (!end() && CUR_TOKEN_IS(LBRACK)) {
        PARSE_TOKEN(LBRACK);
        PARSE(ce, ConstExp);
        PARSE_TOKEN(RBRACK);
    }
    PARSE_TOKEN(ASSIGN);
    PARSE(civ, ConstInitVal);
    return true;
}

bool Parser::parseConstInitVal(frontend::ConstInitVal* root) {
    log(root);
    if (CUR_TOKEN_IS(LBRACE)) {
        PARSE_TOKEN(LBRACE);
        if (!CUR_TOKEN_IS(RBRACE)) {
            PARSE(one, ConstInitVal);
            while (!end() && CUR_TOKEN_IS(COMMA)) {
                PARSE_TOKEN(COMMA);
                PARSE(more, ConstInitVal);
            }
        }
        PARSE_TOKEN(RBRACE);
    }
    else {
        PARSE(ce, ConstExp);
    }
    return true;
}

bool Parser::parseVarDecl(frontend::VarDecl* root) {
    log(root);
    PARSE(bt, BType);
    PARSE(def, VarDef);
    while (!end() && CUR_TOKEN_IS(COMMA)) {
        PARSE_TOKEN(COMMA);
        PARSE(def2, VarDef);
    }
    PARSE_TOKEN(SEMICN);
    return true;
}

bool Parser::parseVarDef(frontend::VarDef* root) {
    log(root);
    PARSE_TOKEN(IDENFR);
    while (!end() && CUR_TOKEN_IS(LBRACK)) {
        PARSE_TOKEN(LBRACK);
        PARSE(ce, ConstExp);
        PARSE_TOKEN(RBRACK);
    }
    if (!end() && CUR_TOKEN_IS(ASSIGN)) {
        PARSE_TOKEN(ASSIGN);
        PARSE(iv, InitVal);
    }
    return true;
}

bool Parser::parseInitVal(frontend::InitVal* root) {
    log(root);
    if (CUR_TOKEN_IS(LBRACE)) {
        PARSE_TOKEN(LBRACE);
        if (!CUR_TOKEN_IS(RBRACE)) {
            PARSE(one, InitVal);
            while (!end() && CUR_TOKEN_IS(COMMA)) {
                PARSE_TOKEN(COMMA);
                PARSE(more, InitVal);
            }
        }
        PARSE_TOKEN(RBRACE);
    }
    else {
        PARSE(e, Exp);
    }
    return true;
}

bool Parser::parseFuncType(frontend::FuncType* root) {
    log(root);
    if (CUR_TOKEN_IS(VOIDTK)) {
        PARSE_TOKEN(VOIDTK);
        return true;
    }
    if (CUR_TOKEN_IS(INTTK)) {
        PARSE_TOKEN(INTTK);
        return true;
    }
    if (CUR_TOKEN_IS(FLOATTK)) {
        PARSE_TOKEN(FLOATTK);
        return true;
    }
    return false;
}

bool Parser::parseFuncFParam(frontend::FuncFParam* root) {
    log(root);
    PARSE(bt, BType);
    PARSE_TOKEN(IDENFR);
    if (!end() && CUR_TOKEN_IS(LBRACK)) {
        PARSE_TOKEN(LBRACK);
        PARSE_TOKEN(RBRACK);
        while (!end() && CUR_TOKEN_IS(LBRACK)) {
            PARSE_TOKEN(LBRACK);
            PARSE(e, Exp);
            PARSE_TOKEN(RBRACK);
        }
    }
    return true;
}

bool Parser::parseFuncFParams(frontend::FuncFParams* root) {
    log(root);
    PARSE(param, FuncFParam);
    while (!end() && CUR_TOKEN_IS(COMMA)) {
        PARSE_TOKEN(COMMA);
        PARSE(param2, FuncFParam);
    }
    return true;
}

bool Parser::parseBlock(frontend::Block* root) {
    log(root);
    PARSE_TOKEN(LBRACE);
    while (!end() && !CUR_TOKEN_IS(RBRACE)) {
        PARSE(item, BlockItem);
    }
    PARSE_TOKEN(RBRACE);
    return true;
}

bool Parser::parseBlockItem(frontend::BlockItem* root) {
    log(root);
    if (isDeclStart()) {
        PARSE(d, Decl);
        return true;
    }
    PARSE(s, Stmt);
    return true;
}

bool Parser::parseStmt(frontend::Stmt* root) {
    log(root);
    if (CUR_TOKEN_IS(LBRACE)) {
        PARSE(b, Block);
        return true;
    }
    if (CUR_TOKEN_IS(IFTK)) {
        PARSE_TOKEN(IFTK);
        PARSE_TOKEN(LPARENT);
        PARSE(c, Cond);
        PARSE_TOKEN(RPARENT);
        PARSE(s1, Stmt);
        if (!end() && CUR_TOKEN_IS(ELSETK)) {
            PARSE_TOKEN(ELSETK);
            PARSE(s2, Stmt);
        }
        return true;
    }
    if (CUR_TOKEN_IS(WHILETK)) {
        PARSE_TOKEN(WHILETK);
        PARSE_TOKEN(LPARENT);
        PARSE(c, Cond);
        PARSE_TOKEN(RPARENT);
        PARSE(s, Stmt);
        return true;
    }
    if (CUR_TOKEN_IS(BREAKTK)) {
        PARSE_TOKEN(BREAKTK);
        PARSE_TOKEN(SEMICN);
        return true;
    }
    if (CUR_TOKEN_IS(CONTINUETK)) {
        PARSE_TOKEN(CONTINUETK);
        PARSE_TOKEN(SEMICN);
        return true;
    }
    if (CUR_TOKEN_IS(RETURNTK)) {
        PARSE_TOKEN(RETURNTK);
        if (!CUR_TOKEN_IS(SEMICN)) {
            PARSE(e, Exp);
        }
        PARSE_TOKEN(SEMICN);
        return true;
    }

    if (CUR_TOKEN_IS(SEMICN)) {
        PARSE_TOKEN(SEMICN);
        return true;
    }

    if (isLValAssignStart()) {
        PARSE(lv, LVal);
        PARSE_TOKEN(ASSIGN);
        PARSE(e, Exp);
        PARSE_TOKEN(SEMICN);
        return true;
    }

    PARSE(e, Exp);
    PARSE_TOKEN(SEMICN);
    return true;
}

bool Parser::parseExp(frontend::Exp* root) {
    log(root);
    PARSE(add, AddExp);
    return true;
}

bool Parser::parseCond(frontend::Cond* root) {
    log(root);
    PARSE(or_exp, LOrExp);
    return true;
}

bool Parser::parseLVal(frontend::LVal* root) {
    log(root);
    PARSE_TOKEN(IDENFR);
    while (!end() && CUR_TOKEN_IS(LBRACK)) {
        PARSE_TOKEN(LBRACK);
        PARSE(e, Exp);
        PARSE_TOKEN(RBRACK);
    }
    return true;
}

bool Parser::parseNumber(frontend::Number* root) {
    log(root);
    if (CUR_TOKEN_IS(INTLTR)) {
        PARSE_TOKEN(INTLTR);
        return true;
    }
    if (CUR_TOKEN_IS(FLOATLTR)) {
        PARSE_TOKEN(FLOATLTR);
        return true;
    }
    return false;
}

bool Parser::parsePrimaryExp(frontend::PrimaryExp* root) {
    log(root);
    if (CUR_TOKEN_IS(LPARENT)) {
        PARSE_TOKEN(LPARENT);
        PARSE(e, Exp);
        PARSE_TOKEN(RPARENT);
        return true;
    }
    if (CUR_TOKEN_IS(IDENFR)) {
        PARSE(lv, LVal);
        return true;
    }
    PARSE(num, Number);
    return true;
}

bool Parser::parseUnaryExp(frontend::UnaryExp* root) {
    log(root);
    if (CUR_TOKEN_IS(IDENFR) && index + 1 < token_stream.size() && lookahead(1).type == frontend::TokenType::LPARENT) {
        PARSE_TOKEN(IDENFR);
        PARSE_TOKEN(LPARENT);
        if (!CUR_TOKEN_IS(RPARENT)) {
            PARSE(params, FuncRParams);
        }
        PARSE_TOKEN(RPARENT);
        return true;
    }
    if (CUR_TOKEN_IS(PLUS) || CUR_TOKEN_IS(MINU) || CUR_TOKEN_IS(NOT)) {
        PARSE(op, UnaryOp);
        PARSE(exp, UnaryExp);
        return true;
    }
    PARSE(pe, PrimaryExp);
    return true;
}

bool Parser::parseUnaryOp(frontend::UnaryOp* root) {
    log(root);
    if (CUR_TOKEN_IS(PLUS)) {
        PARSE_TOKEN(PLUS);
        return true;
    }
    if (CUR_TOKEN_IS(MINU)) {
        PARSE_TOKEN(MINU);
        return true;
    }
    PARSE_TOKEN(NOT);
    return true;
}

bool Parser::parseFuncRParams(frontend::FuncRParams* root) {
    log(root);
    PARSE(e, Exp);
    while (!end() && CUR_TOKEN_IS(COMMA)) {
        PARSE_TOKEN(COMMA);
        PARSE(e2, Exp);
    }
    return true;
}

bool Parser::parseMulExp(frontend::MulExp* root) {
    log(root);
    PARSE(ue, UnaryExp);
    while (!end() && (CUR_TOKEN_IS(MULT) || CUR_TOKEN_IS(DIV) || CUR_TOKEN_IS(MOD))) {
        if (CUR_TOKEN_IS(MULT)) {
            PARSE_TOKEN(MULT);
        }
        else if (CUR_TOKEN_IS(DIV)) {
            PARSE_TOKEN(DIV);
        }
        else {
            PARSE_TOKEN(MOD);
        }
        PARSE(ue2, UnaryExp);
    }
    return true;
}

bool Parser::parseAddExp(frontend::AddExp* root) {
    log(root);
    PARSE(me, MulExp);
    while (!end() && (CUR_TOKEN_IS(PLUS) || CUR_TOKEN_IS(MINU))) {
        if (CUR_TOKEN_IS(PLUS)) {
            PARSE_TOKEN(PLUS);
        }
        else {
            PARSE_TOKEN(MINU);
        }
        PARSE(me2, MulExp);
    }
    return true;
}

bool Parser::parseRelExp(frontend::RelExp* root) {
    log(root);
    PARSE(ae, AddExp);
    while (!end() && (CUR_TOKEN_IS(LSS) || CUR_TOKEN_IS(GTR) || CUR_TOKEN_IS(LEQ) || CUR_TOKEN_IS(GEQ))) {
        if (CUR_TOKEN_IS(LSS)) {
            PARSE_TOKEN(LSS);
        }
        else if (CUR_TOKEN_IS(GTR)) {
            PARSE_TOKEN(GTR);
        }
        else if (CUR_TOKEN_IS(LEQ)) {
            PARSE_TOKEN(LEQ);
        }
        else {
            PARSE_TOKEN(GEQ);
        }
        PARSE(ae2, AddExp);
    }
    return true;
}

bool Parser::parseEqExp(frontend::EqExp* root) {
    log(root);
    PARSE(re, RelExp);
    while (!end() && (CUR_TOKEN_IS(EQL) || CUR_TOKEN_IS(NEQ))) {
        if (CUR_TOKEN_IS(EQL)) {
            PARSE_TOKEN(EQL);
        }
        else {
            PARSE_TOKEN(NEQ);
        }
        PARSE(re2, RelExp);
    }
    return true;
}

bool Parser::parseLAndExp(frontend::LAndExp* root) {
    log(root);
    PARSE(eq, EqExp);
    if (!end() && CUR_TOKEN_IS(AND)) {
        PARSE_TOKEN(AND);
        PARSE(next, LAndExp);
    }
    return true;
}

bool Parser::parseLOrExp(frontend::LOrExp* root) {
    log(root);
    PARSE(land, LAndExp);
    if (!end() && CUR_TOKEN_IS(OR)) {
        PARSE_TOKEN(OR);
        PARSE(next, LOrExp);
    }
    return true;
}

bool Parser::parseConstExp(frontend::ConstExp* root) {
    log(root);
    PARSE(add, AddExp);
    return true;
}

void Parser::log(AstNode* node){
#ifdef DEBUG_PARSER
        std::cout << "in parse" << toString(node->type) << ", cur_token_type::" << toString(token_stream[index].type) << ", token_val::" << token_stream[index].value << '\n';
#endif
}
