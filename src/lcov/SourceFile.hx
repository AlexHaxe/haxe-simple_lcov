package lcov;

/** Provides the coverage data of a source file. **/
class SourceFile {
	public var branches(default, null):Null<BranchCoverage> = null;

	public var functions(default, null):Null<FunctionCoverage> = null;

	public var lines(default, null):Null<LineCoverage> = null;

	/** The path to the source file. **/
	public var path(default, null):String;

	public function new(path:String) {
		this.path = path;
		if (path != "") {
			branches = new BranchCoverage(0, 0);
			functions = new FunctionCoverage(0, 0);
			lines = new LineCoverage();
		}
	}

	/** Returns a string representation of this object. **/
	public function toString():String {
		final output = ['${Token.SourceFile}:$path'];
		if (functions != null) {
			output.push(functions.toString());
		}
		if (branches != null) {
			output.push(branches.toString());
		}
		if (lines != null) {
			output.push(lines.toString());
		}
		output.push(Token.EndOfRecord);
		return output.join("\n");
	}
}
