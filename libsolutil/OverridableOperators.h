#pragma once

#include <liblangutil/Token.h>

#include <vector>

using namespace solidity::langutil;

namespace solidity::util
{

std::vector<Token> const overridableOperators = {
	Token::BitOr, Token::BitAnd, Token::BitXor,
	Token::Add, Token::Sub, Token::Mul, Token::Div, Token::Mod,
	Token::Equal, Token::NotEqual,
	Token::LessThan, Token::GreaterThan, Token::LessThanOrEqual, Token::GreaterThanOrEqual,
	Token::BitNot, Token::SHL, Token::SAR, Token::Exp, Token::Not
};

}
