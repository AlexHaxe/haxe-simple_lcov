package lcov;

class BranchDataTest implements ITest {
	public function new() {}

	public function testToString() {
		// It should return a format like "BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>".
		Assert.equals("BRDA:0,0,0,-", new BranchData(0, 0, 0).toString());
		Assert.equals("BRDA:127,3,2,1", new BranchData(127, 3, 2, 1).toString());
	}
}
