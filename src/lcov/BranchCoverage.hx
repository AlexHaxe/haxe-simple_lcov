package lcov;

/** Provides the coverage data of branches. **/
class BranchCoverage {
	public var data(default, null):Array<BranchData> = [];

	/** The number of branches found. **/
	public var found:Int = 0;

	/** The number of branches hit. **/
	public var hit:Int = 0;

	public function new(?found:Int, ?hit:Int, ?data:Array<BranchData>) {
		if (found != null) {
			this.found = found;
		}
		if (hit != null) {
			this.hit = hit;
		}
		if (data != null) {
			this.data = data;
		}
	}

	/** Returns a string representation of this object. **/
	public function toString():String {
		final lines = data.map(item -> item.toString());
		lines.push('${Token.BranchesFound}:$found');
		lines.push('${Token.BranchesHit}:$hit');
		return lines.join("\n");
	}
}
