package lcov;

enum LcovParseResult {
	Failure(error:String);
	Success(report:Report);
}
