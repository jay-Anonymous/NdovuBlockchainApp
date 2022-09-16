using {add as +} for C.Event;

contract C {
    event Event();
}


function add(C.Event, C.Event) pure returns (C.Event) {
    return C.Event.E1;
}

// ----
// TypeError 5172: (21-28): Name has to refer to a user-defined value type, struct, enum or contract.
