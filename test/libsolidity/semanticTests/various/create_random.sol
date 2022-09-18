contract A {
    uint256 public immutable createdOn = block.number;
}

contract C {
    function addr() external returns (address) {
        return address(this);
    }

    function test() external returns (address a1, address a2) {
        bytes memory creation = type(A).creationCode;

        assembly {
            a1 := create(0, add(creation, 32), mload(creation))
            a2 := create2(0, add(creation, 32), mload(creation), address())
        }
    }
}

// ----
// addr() -> 0xbe9efd422ee479f010753a6bc06afe3a8444fc00
// test() -> 0xf467baad569be981fb1a781f640de36059cd774a, 0x4e76c5b8db09c0f1be7f40921d7fec817e358ab7
// gas legacy: 148082
