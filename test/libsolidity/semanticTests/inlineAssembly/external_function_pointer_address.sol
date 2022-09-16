contract C {
	function testFunction() external {}

	function testYul() public returns (address adr) {
		function() external fp = this.testFunction;

		assembly {
			adr := fp.address
		}
	}
	function testSol() public returns (address) {
		return this.testFunction.address;
	}
}
// ----
// testYul() -> 0xbe9efd422ee479f010753a6bc06afe3a8444fc00
// testSol() -> 0xbe9efd422ee479f010753a6bc06afe3a8444fc00
