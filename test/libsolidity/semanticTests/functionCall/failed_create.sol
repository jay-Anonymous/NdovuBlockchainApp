contract D { constructor() payable {} }
contract C {
	uint public x;
	constructor() payable {}
	function f(uint amount) public returns (D) {
		x++;
		return (new D){value: amount}();
	}
	function stack(uint depth) public payable returns (address) {
		if (depth > 0)
			return this.stack(depth - 1);
		else
			return address(f(0));
	}
}
// ====
// EVMVersion: >=byzantium
// ----
// constructor(), 20 wei
// gas irOptimized: 184005
// gas legacy: 294335
// gas legacyOptimized: 173427
// f(uint256): 20 -> 1395306986705621432574854751704866826339929126730
// x() -> 1
// f(uint256): 20 -> FAILURE
// x() -> 1
// stack(uint256): 1023 -> FAILURE
// gas irOptimized: 260987
// gas legacy: 483942
// gas legacyOptimized: 302349
// x() -> 1
// stack(uint256): 10 -> 663419477067344678851233034241644096732894503430
// x() -> 2
