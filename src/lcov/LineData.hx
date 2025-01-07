package lcov;

/** Provides details for line coverage. **/
@:structInit class LineData {
	public var checksum(default, null):String = "";

	public var executionCount(default, null):Int = 0;

	public var lineNumber(default, null):Int = 0;

	public function new(lineNumber:Int, ?executionCount:Int, ?checksum:String) {
		this.lineNumber = lineNumber;
		if (executionCount != null) {
			this.executionCount = executionCount;
		}
		if (checksum != null) {
			this.checksum = checksum;
		}
	}

	/** Returns a string representation of this object. **/
	public function toString():String {
		final value = '${Token.LineData}:$lineNumber,$executionCount';
		return checksum.length > 0 ? '$value,$checksum' : value;
	}
}
