package lcov;

class FunctionCoverageTest implements ITest {
	public function new() {}

	public function testToString() {
		// It should return a format like "FNF:<found>\nFNH:<hit>".
		final coverage = new FunctionCoverage(23, 11, [new FunctionData("main", 127, 3)]);
		Assert.equals("FNF:0\nFNH:0", new FunctionCoverage(0, 0).toString());
		Assert.equals("FN:127,main\nFNDA:3,main\nFNF:23\nFNH:11", coverage.toString());
	}
}
