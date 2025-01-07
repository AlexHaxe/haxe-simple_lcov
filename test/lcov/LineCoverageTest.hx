package lcov;

class LineCoverageTest implements ITest {
	public function new() {}

	public function testToString() {
		// It should return a format like "LF:<found>\nLH:<hit>".
		final data = new LineData(127, 3);
		Assert.equals("LF:0\nLH:0", new LineCoverage().toString());
		Assert.equals('$data\nLF:23\nLH:11', new LineCoverage(23, 11, [data]).toString());
	}
}
