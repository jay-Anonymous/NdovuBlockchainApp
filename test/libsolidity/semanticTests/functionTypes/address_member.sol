contract C {
    function f() public view returns (address a1, address a2) {
        a1 = this.f.address;
        this.f.address;
        [this.f.address][0];
        a2 = [this.f.address][0];
    }
}
// ====
// compileToEwasm: also
// ----
// f() -> 0xbe9efd422ee479f010753a6bc06afe3a8444fc00, 0xbe9efd422ee479f010753a6bc06afe3a8444fc00
