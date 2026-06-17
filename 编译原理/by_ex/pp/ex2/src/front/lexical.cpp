#include"front/lexical.h"

#include<map>
#include<cassert>
#include<string>
#include<cctype>
#include<vector>

// #define DEBUG_DFA
// #define DEBUG_SCANNER

std::string frontend::toString(State s) {
    switch (s) {
    case State::Empty: return "Empty";
    case State::Ident: return "Ident";
    case State::IntLiteral: return "IntLiteral";
    case State::FloatLiteral: return "FloatLiteral";
    case State::op: return "op";
    default:
        assert(0 && "invalid State");
    }
    return "";
}

std::set<std::string> frontend::keywords= {
    "const", "int", "float", "if", "else", "while", "continue", "break", "return", "void"
};

frontend::DFA::DFA(): cur_state(frontend::State::Empty), cur_str() {}

frontend::DFA::~DFA() {}

bool frontend::DFA::next(char input, Token& buf) {
#ifdef DEBUG_DFA
#include<iostream>
    std::cout << "in state [" << toString(cur_state) << "], input = \'" << input << "\', str = " << cur_str << "\t";
#endif
    bool ret = false;
    auto is_ident_start = [](char c) {
        return std::isalpha(static_cast<unsigned char>(c)) || c == '_';
    };
    auto is_ident_char = [&](char c) {
        return is_ident_start(c) || std::isdigit(static_cast<unsigned char>(c));
    };

    switch (cur_state) {
    case State::Empty:
        if (std::isspace(static_cast<unsigned char>(input))) {
            ret = false;
        }
        else if (is_ident_start(input)) {
            cur_state = State::Ident;
            cur_str.push_back(input);
        }
        else if (std::isdigit(static_cast<unsigned char>(input))) {
            cur_state = State::IntLiteral;
            cur_str.push_back(input);
        }
        else {
            cur_state = State::op;
            cur_str.push_back(input);
            buf.value = cur_str;
            static const std::map<std::string, TokenType> op_map = {
                {"+", TokenType::PLUS}, {"-", TokenType::MINU}, {"*", TokenType::MULT}, {"/", TokenType::DIV},
                {"%", TokenType::MOD}, {"<", TokenType::LSS}, {">", TokenType::GTR}, {":", TokenType::COLON},
                {"=", TokenType::ASSIGN}, {";", TokenType::SEMICN}, {",", TokenType::COMMA}, {"(", TokenType::LPARENT},
                {")", TokenType::RPARENT}, {"[", TokenType::LBRACK}, {"]", TokenType::RBRACK}, {"{", TokenType::LBRACE},
                {"}", TokenType::RBRACE}, {"!", TokenType::NOT}
            };
            auto it = op_map.find(cur_str);
            if (it != op_map.end()) {
                buf.type = it->second;
                ret = true;
            }
            reset();
        }
        break;
    case State::Ident:
        if (is_ident_char(input)) {
            cur_str.push_back(input);
        }
        else {
            buf.value = cur_str;
            if (keywords.count(cur_str)) {
                static const std::map<std::string, TokenType> key_map = {
                    {"const", TokenType::CONSTTK}, {"void", TokenType::VOIDTK}, {"int", TokenType::INTTK},
                    {"float", TokenType::FLOATTK}, {"if", TokenType::IFTK}, {"else", TokenType::ELSETK},
                    {"while", TokenType::WHILETK}, {"continue", TokenType::CONTINUETK}, {"break", TokenType::BREAKTK},
                    {"return", TokenType::RETURNTK}
                };
                buf.type = key_map.at(cur_str);
            }
            else {
                buf.type = TokenType::IDENFR;
            }
            reset();
            ret = true;
        }
        break;
    case State::IntLiteral:
        if (std::isdigit(static_cast<unsigned char>(input))) {
            cur_str.push_back(input);
        }
        else if (input == '.') {
            cur_state = State::FloatLiteral;
            cur_str.push_back(input);
        }
        else {
            buf.type = TokenType::INTLTR;
            buf.value = cur_str;
            reset();
            ret = true;
        }
        break;
    case State::FloatLiteral:
        if (std::isdigit(static_cast<unsigned char>(input))) {
            cur_str.push_back(input);
        }
        else {
            buf.type = TokenType::FLOATLTR;
            buf.value = cur_str;
            reset();
            ret = true;
        }
        break;
    case State::op:
        reset();
        break;
    default:
        assert(0 && "invalid state");
    }
#ifdef DEBUG_DFA
    std::cout << "next state is [" << toString(cur_state) << "], next str = " << cur_str << "\t, ret = " << ret << std::endl;
#endif
    return ret;
}

void frontend::DFA::reset() {
    cur_state = State::Empty;
    cur_str = "";
}

frontend::Scanner::Scanner(std::string filename): fin(filename) {
    if(!fin.is_open()) {
        assert(0 && "in Scanner constructor, input file cannot open");
    }
}

frontend::Scanner::~Scanner() {
    fin.close();
}

std::vector<frontend::Token> frontend::Scanner::run() {
    std::vector<Token> ret;
    std::string src;
    {
        std::string line;
        while (std::getline(fin, line)) {
            src += line;
            src.push_back('\n');
        }
    }

    static const std::map<std::string, TokenType> key_map = {
        {"const", TokenType::CONSTTK}, {"void", TokenType::VOIDTK}, {"int", TokenType::INTTK},
        {"float", TokenType::FLOATTK}, {"if", TokenType::IFTK}, {"else", TokenType::ELSETK},
        {"while", TokenType::WHILETK}, {"continue", TokenType::CONTINUETK}, {"break", TokenType::BREAKTK},
        {"return", TokenType::RETURNTK}
    };
    static const std::map<std::string, TokenType> op2_map = {
        {"<=", TokenType::LEQ}, {">=", TokenType::GEQ}, {"==", TokenType::EQL},
        {"!=", TokenType::NEQ}, {"&&", TokenType::AND}, {"||", TokenType::OR}
    };
    static const std::map<char, TokenType> op1_map = {
        {'+', TokenType::PLUS}, {'-', TokenType::MINU}, {'*', TokenType::MULT}, {'/', TokenType::DIV},
        {'%', TokenType::MOD}, {'<', TokenType::LSS}, {'>', TokenType::GTR}, {':', TokenType::COLON},
        {'=', TokenType::ASSIGN}, {';', TokenType::SEMICN}, {',', TokenType::COMMA}, {'(', TokenType::LPARENT},
        {')', TokenType::RPARENT}, {'[', TokenType::LBRACK}, {']', TokenType::RBRACK}, {'{', TokenType::LBRACE},
        {'}', TokenType::RBRACE}, {'!', TokenType::NOT}
    };

    size_t i = 0;
    while (i < src.size()) {
        char c = src[i];

        if (std::isspace(static_cast<unsigned char>(c))) {
            ++i;
            continue;
        }

        if (c == '/' && i + 1 < src.size()) {
            if (src[i + 1] == '/') {
                i += 2;
                while (i < src.size() && src[i] != '\n') {
                    ++i;
                }
                continue;
            }
            if (src[i + 1] == '*') {
                i += 2;
                while (i + 1 < src.size() && !(src[i] == '*' && src[i + 1] == '/')) {
                    ++i;
                }
                if (i + 1 < src.size()) {
                    i += 2;
                }
                continue;
            }
        }

        if (std::isalpha(static_cast<unsigned char>(c)) || c == '_') {
            size_t j = i + 1;
            while (j < src.size()) {
                char cj = src[j];
                if (std::isalnum(static_cast<unsigned char>(cj)) || cj == '_') {
                    ++j;
                }
                else {
                    break;
                }
            }
            std::string word = src.substr(i, j - i);
            Token tk;
            tk.value = word;
            auto it = key_map.find(word);
            tk.type = (it == key_map.end()) ? TokenType::IDENFR : it->second;
            ret.push_back(tk);
            i = j;
            continue;
        }

        if (std::isdigit(static_cast<unsigned char>(c))) {
            size_t j = i;
            bool is_float = false;

            if (src[j] == '0' && j + 1 < src.size() && (src[j + 1] == 'x' || src[j + 1] == 'X')) {
                j += 2;
                while (j < src.size() && std::isxdigit(static_cast<unsigned char>(src[j]))) {
                    ++j;
                }
            }
            else {
                while (j < src.size() && std::isdigit(static_cast<unsigned char>(src[j]))) {
                    ++j;
                }
                if (j < src.size() && src[j] == '.') {
                    is_float = true;
                    ++j;
                    while (j < src.size() && std::isdigit(static_cast<unsigned char>(src[j]))) {
                        ++j;
                    }
                }
            }

            Token tk;
            tk.value = src.substr(i, j - i);
            tk.type = is_float ? TokenType::FLOATLTR : TokenType::INTLTR;
            ret.push_back(tk);
            i = j;
            continue;
        }

        if (c == '.' && i + 1 < src.size() && std::isdigit(static_cast<unsigned char>(src[i + 1]))) {
            size_t j = i + 1;
            while (j < src.size() && std::isdigit(static_cast<unsigned char>(src[j]))) {
                ++j;
            }
            Token tk;
            tk.value = src.substr(i, j - i);
            tk.type = TokenType::FLOATLTR;
            ret.push_back(tk);
            i = j;
            continue;
        }

        if (i + 1 < src.size()) {
            std::string op2 = src.substr(i, 2);
            auto it2 = op2_map.find(op2);
            if (it2 != op2_map.end()) {
                Token tk;
                tk.type = it2->second;
                tk.value = op2;
                ret.push_back(tk);
                i += 2;
                continue;
            }
        }

        auto it1 = op1_map.find(c);
        if (it1 != op1_map.end()) {
            Token tk;
            tk.type = it1->second;
            tk.value = std::string(1, c);
            ret.push_back(tk);
            ++i;
            continue;
        }

        assert(0 && "invalid character in source");
    }

    return ret;
#ifdef DEBUG_SCANNER
#include<iostream>
            std::cout << "token: " << toString(tk.type) << "\t" << tk.value << std::endl;
#endif
}