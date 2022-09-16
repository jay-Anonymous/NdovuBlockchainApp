contract C {
    event Test(function() external indexed);
    function f() public {
        emit Test(this.f);
    }
}
// ----
// f() ->
// ~ emit Test(function): #0xbe9efd422ee479f010753a6bc06afe3a8444fc0026121ff00000000000000000
