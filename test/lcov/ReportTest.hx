package lcov;

import sys.io.File;

class ReportTest implements ITest {
	public function new() {}

	public function testParse() {
		final result = Report.parse(File.getContent("test/fixtures/lcov.info"));

		var report:Report = null;
		switch (result) {
			case Failure(error):
				Assert.fail(error);
				return;
			case Success(r):
				report = r;
		}

		Assert.notNull(report);
		// It should have a test name.
		Assert.equals("Example", report.testName);

		// It should contain three records.
		Assert.equals(3, report.sourceFiles.length);

		Assert.equals("/home/user/lcov.hx/fixture.hx", report.sourceFiles[0].path);
		Assert.equals("/home/user/lcov.hx/func1.hx", report.sourceFiles[1].path);
		Assert.equals("/home/user/lcov.hx/func2.hx", report.sourceFiles[2].path);

		// It should have detailed branch coverage.
		final branches = report.sourceFiles[1].branches;
		Assert.equals(4, branches.found);
		Assert.equals(4, branches.hit);

		Assert.equals(4, branches.data.length);
		Assert.equals(8, branches.data[0].lineNumber);

		// It should have detailed function coverage.
		final functions = report.sourceFiles[1].functions;
		Assert.equals(1, functions.found);
		Assert.equals(1, functions.hit);

		Assert.equals(1, functions.data.length);
		Assert.equals("func1", functions.data[0].functionName);

		// It should have detailed line coverage.
		final lines = report.sourceFiles[1].lines;
		Assert.equals(9, lines.found);
		Assert.equals(9, lines.hit);

		Assert.equals(9, lines.data.length);
		Assert.equals("5kX7OTfHFcjnS98fjeVqNA", lines.data[0].checksum);
	}

	public function testParseInvalidInput() {
		var result = Report.parse("ZZ");
		switch (result) {
			case Failure(error):
				Assert.notNull(error);
				return;
			case Success(r):
				Assert.fail("should return failure on invalid input");
		}
	}

	public function testParseEmptyReport() {
		var result = Report.parse("TN:Example");
		switch (result) {
			case Failure(error):
				Assert.notNull(error);
				return;
			case Success(r):
				Assert.fail("should return failure on empty report");
		}
	}

	public function testToString() {
		// It should return a format like "TN:<testName>".
		final sourceFile = new SourceFile("");
		Assert.equals(0, new Report().toString().length);
		Assert.equals('TN:LcovTest\n$sourceFile', new Report("LcovTest", [sourceFile]).toString());
	}
}
