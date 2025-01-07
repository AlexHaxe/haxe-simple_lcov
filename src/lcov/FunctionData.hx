package lcov;

/** Provides details for function coverage. **/
@:structInit class FunctionData {
	public var executionCount:Int = 0;

	public var functionName(default, null):String = "";

	/** The line number of the function start. **/
	public var lineNumber(default, null):Int = 0;

	public function new(functionName:String, lineNumber:Int, ?executionCount:Int) {
		this.functionName = functionName;
		this.lineNumber = lineNumber;
		if (executionCount != null) {
			this.executionCount = executionCount;
		}
	}

	/** Returns a string representation of this object. **/
	public function toString(asDefinition = false):String {
		final token:Token = asDefinition ? FunctionName : FunctionData;
		final number = asDefinition ? lineNumber : executionCount;
		return '$token:$number,$functionName';
	}
}
