package lcov;

class BranchCoverageTest implements ITest {
	public function new() {}

	public function testToString() {
		// It should return a format like "BRF:<found>\nBRH:<hit>".
		Assert.equals("BRF:0\nBRH:0", new BranchCoverage().toString());

		final data = new BranchData(127, 3, 2, 1);
		Assert.equals('$data\nBRF:23\nBRH:11', new BranchCoverage(23, 11, [data]).toString());
	}
}
