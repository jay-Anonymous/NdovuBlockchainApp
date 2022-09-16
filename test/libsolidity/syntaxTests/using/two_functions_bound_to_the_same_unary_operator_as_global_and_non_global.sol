type Int is int;

using {unsub as -} for Int global;
using {another_unsub as -} for Int;

function unsub(Int, Int) pure returns (Int) {
    return Int.wrap(0);
}

function another_unsub(Int, Int) pure returns (Int) {
    return Int.wrap(0);
}

function test() pure returns (Int) {
    return -Int.wrap(2);
}

// ----
// TypeError 4907: (292-304): Built-in unary operator - cannot be applied to type Int. No matching user-defined operator found.
