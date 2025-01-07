package lcov;

/** Provides details for branch coverage. **/
@:structInit class BranchData {
	public var blockNumber(default, null):Int = 0;

	public var branchNumber(default, null):Int = 0;

	public var lineNumber(default, null):Int = 0;

	/** A number indicating how often this branch was taken. **/
	public var taken(default, null):Int = 0;

	public function new(lineNumber:Int, blockNumber:Int, branchNumber:Int, ?taken:Int) {
		this.lineNumber = lineNumber;
		this.blockNumber = blockNumber;
		this.branchNumber = branchNumber;
		if (taken != null) {
			this.taken = taken;
		}
	}

	/** Returns a string representation of this object. **/
	public function toString():String {
		final value = '${Token.BranchData}:$lineNumber,$blockNumber,$branchNumber';
		return taken > 0 ? '$value,$taken' : '$value,-';
	}
}
