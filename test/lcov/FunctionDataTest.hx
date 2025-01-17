package lcov;

class FunctionDataTest implements ITest {
	public function new() {}

	public function testToString() {
		// It should return a format like "FN:<lineNumber>,<functionName>" when used as definition.
		Assert.equals("FN:0,", new FunctionData("", 0).toString(true));
		Assert.equals("FN:127,main", new FunctionData("main", 127, 3).toString(true));

		// It should return a format like "FNDA:<executionCount>,<functionName>" when used as data.
		Assert.equals("FNDA:0,", new FunctionData("", 0).toString(false));
		Assert.equals("FNDA:3,main", new FunctionData("main", 127, 3).toString(false));
	}
}
