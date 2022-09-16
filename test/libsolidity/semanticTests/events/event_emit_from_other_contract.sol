contract D {
    event Deposit(address indexed _from, bytes32 indexed _id, uint _value);
    function deposit(bytes32 _id) public payable {
        emit Deposit(msg.sender, _id, msg.value);
    }
}
contract C {
    D d;
    constructor() {
        d = new D();
    }
    function deposit(bytes32 _id) public payable {
        d.deposit(_id);
    }
}
// ----
// constructor() ->
// gas irOptimized: 166854
// gas legacy: 250376
// gas legacyOptimized: 174522
// deposit(bytes32), 18 wei: 0x1234 ->
// ~ emit Deposit(address,bytes32,uint256) from 0xf467baad569be981fb1a781f640de36059cd774a: #0xbe9efd422ee479f010753a6bc06afe3a8444fc00, #0x1234, 0x00
