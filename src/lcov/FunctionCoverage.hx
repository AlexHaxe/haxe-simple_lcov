package lcov;

/** Provides the coverage data of functions. **/
class FunctionCoverage {
	public var data(default, null):Array<FunctionData> = [];

	/** The number of functions found. **/
	public var found:Int = 0;

	/** The number of functions hit. **/
	public var hit:Int = 0;

	public function new(found:Int, hit:Int, ?data:Array<FunctionData>) {
		this.found = found;
		this.hit = hit;
		if (data != null) {
			this.data = data;
		}
	}

	/** Returns a string representation of this object. **/
	public function toString():String {
		final lines = data.map(item -> item.toString(true));
		for (line in data.map(item -> item.toString(false))) {
			lines.push(line);
		}
		lines.push('${Token.FunctionsFound}:$found');
		lines.push('${Token.FunctionsHit}:$hit');
		return lines.join("\n");
	}
}
