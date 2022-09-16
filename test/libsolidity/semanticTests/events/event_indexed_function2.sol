contract C {
    event TestA(function() external indexed);
    event TestB(function(uint256) external indexed);
    function f1() public {
        emit TestA(this.f1);
    }
    function f2(uint256 a) public {
        emit TestB(this.f2);
    }
}
// ----
// f1() ->
// ~ emit TestA(function): #0xbe9efd422ee479f010753a6bc06afe3a8444fc00c27fc3050000000000000000
// f2(uint256): 1 ->
// ~ emit TestB(function): #0xbe9efd422ee479f010753a6bc06afe3a8444fc00bf3724af0000000000000000
