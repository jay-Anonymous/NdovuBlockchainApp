function s8(uint mantissa, int8 exponent) pure returns (uint) { }
function s64(uint mantissa, int64 exponent) pure returns (uint) { }
function s160(uint mantissa, int160 exponent) pure returns (uint) { }
function s256(uint mantissa, int256 exponent) pure returns (uint) { }

contract C {
    function f() public pure {
        3.1415 s8;
        3.1415 s64;
        3.1415 s160;
        3.1415 s256;
    }
}
// ----
// TypeError 3123: (327-336): The exponent parameter of a literal suffix function must be unsigned. Exponent is always either zero or a negative power of 10 but the parameter represents its absolute value.
// TypeError 3123: (346-356): The exponent parameter of a literal suffix function must be unsigned. Exponent is always either zero or a negative power of 10 but the parameter represents its absolute value.
// TypeError 3123: (366-377): The exponent parameter of a literal suffix function must be unsigned. Exponent is always either zero or a negative power of 10 but the parameter represents its absolute value.
// TypeError 3123: (387-398): The exponent parameter of a literal suffix function must be unsigned. Exponent is always either zero or a negative power of 10 but the parameter represents its absolute value.
