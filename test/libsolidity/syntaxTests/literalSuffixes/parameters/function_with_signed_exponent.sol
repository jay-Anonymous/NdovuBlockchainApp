struct Float {
    uint mantissa;
    int exponent;
}

function f(uint mantissa, int exponent) pure returns (Float memory) {
    return Float(mantissa, exponent);
}

contract C {
    Float public pi = 3.1415 f;
}
// ----
// TypeError 3123: (201-209): The type of the exponent must be unsigned for decimal literal suffix functions.
