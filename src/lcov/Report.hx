package lcov;

/** Represents a trace file, that is a coverage report. **/
class Report {
	public var sourceFiles(default, null):Array<SourceFile> = [];

	public var testName(default, null):String;

	public function new(testName:String = "", ?sourceFiles:Array<SourceFile>) {
		this.testName = testName;
		if (sourceFiles != null) {
			this.sourceFiles = sourceFiles;
		}
	}

	/** Parses the specified `coverage` data in LCOV format. **/
	public static function parse(coverage:String):LcovParseResult {
		final report = new Report("");
		var offset = 0;
		var sourceFile = new SourceFile("");

		for (line in ~/\r?\n/g.split(coverage)) {
			offset++;
			line = line.trim();
			if (line.length == 0) {
				continue;
			}

			final parts = line.split(":");
			if (parts.length < 2 && parts[0] != Token.EndOfRecord) {
				return Failure('Invalid token format at line #$offset.');
			}

			final token:Token = parts.shift();
			final data = parts.join(":").split(",");

			switch token {
				case TestName:
					if (report.testName.length == 0) {
						report.testName = data[0];
					}
				case EndOfRecord:
					report.sourceFiles.push(sourceFile);

				case BranchData:
					if (data.length < 4) {
						return Failure('Invalid branch data at line #$offset.');
					}
					sourceFile.branches.data.push({
						blockNumber: Std.parseInt(data[1]),
						branchNumber: Std.parseInt(data[2]),
						lineNumber: Std.parseInt(data[0]),
						taken: data[3] == "-" ? 0 : Std.parseInt(data[3])
					});

				case FunctionData:
					if (data.length < 2) {
						return Failure('Invalid function data at line #$offset.');
					}
					if (sourceFile.functions != null)
						for (item in sourceFile.functions.data)
							if (item.functionName == data[1]) {
								item.executionCount = Std.parseInt(data[0]);
								break;
							}

				case FunctionName:
					if (data.length < 2) {
						return Failure('Invalid function name at line #$offset.');
					}
					sourceFile.functions.data.push({
						functionName: data[1],
						lineNumber: Std.parseInt(data[0])
					});

				case LineData:
					if (data.length < 2) {
						return Failure('Invalid line data at line #$offset.');
					}
					sourceFile.lines.data.push({
						checksum: data.length >= 3 ? data[2] : "",
						executionCount: Std.parseInt(data[1]),
						lineNumber: Std.parseInt(data[0])
					});

				case SourceFile:
					sourceFile = new SourceFile(data[0]);

				case BranchesFound:
					if (sourceFile.branches != null) {
						sourceFile.branches.found = Std.parseInt(data[0]);
					}
				case BranchesHit:
					if (sourceFile.branches != null) {
						sourceFile.branches.hit = Std.parseInt(data[0]);
					}
				case FunctionsFound:
					if (sourceFile.functions != null) {
						sourceFile.functions.found = Std.parseInt(data[0]);
					}
				case FunctionsHit:
					if (sourceFile.functions != null) {
						sourceFile.functions.hit = Std.parseInt(data[0]);
					}
				case LinesFound:
					if (sourceFile.lines != null) {
						sourceFile.lines.found = Std.parseInt(data[0]);
					}
				case LinesHit:
					if (sourceFile.lines != null) {
						sourceFile.lines.hit = Std.parseInt(data[0]);
					}
				case _:
					return Failure('Unknown token at line #$offset.');
			}
		}

		return report.sourceFiles.length > 0 ? Success(report) : Failure("The coverage data is empty or invalid.");
	}

	/** Returns a string representation of this object. **/
	public function toString():String {
		final lines = testName.length > 0 ? ['${Token.TestName}:$testName'] : [];
		for (sourceFile in sourceFiles.map(item -> item.toString())) {
			lines.push(sourceFile);
		}
		return lines.join("\n");
	}
}
