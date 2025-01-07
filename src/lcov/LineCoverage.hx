package lcov;

/** Provides the coverage data of lines. **/
class LineCoverage {
	public var data(default, null):Array<LineData> = [];

	/** The number of lines found. **/
	public var found:Int = 0;

	/** The number of lines hit. **/
	public var hit:Int = 0;

	public function new(?found:Int, ?hit:Int, ?data:Array<LineData>) {
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
		lines.push('${Token.LinesFound}:$found');
		lines.push('${Token.LinesHit}:$hit');
		return lines.join("\n");
	}
}
