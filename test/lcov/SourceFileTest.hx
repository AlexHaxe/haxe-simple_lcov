package lcov;

class SourceFileTest implements ITest {
	public function new() {}

	public function testToString() {
		final sourceFile = new SourceFile("/home/user/lcov.hx");

		Assert.equals("SF:\nend_of_record", new SourceFile("").toString());
		Assert.equals('SF:/home/user/lcov.hx\n${sourceFile.functions}\n${sourceFile.branches}\n${sourceFile.lines}\nend_of_record', sourceFile.toString());
	}
}
