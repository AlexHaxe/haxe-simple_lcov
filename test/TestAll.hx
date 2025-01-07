import lcov.BranchCoverageTest;
import lcov.BranchDataTest;
import lcov.FunctionCoverageTest;
import lcov.FunctionDataTest;
import lcov.LineCoverageTest;
import lcov.LineDataTest;
import lcov.ReportTest;
import lcov.SourceFileTest;
import utest.Runner;
import utest.ui.text.DiagnosticsReport;

class TestAll {
	static function main():Void {
		var tests:Array<() -> ITest> = [
			BranchCoverageTest.new,
			BranchDataTest.new,
			FunctionCoverageTest.new,
			FunctionDataTest.new,
			LineCoverageTest.new,
			LineDataTest.new,
			ReportTest.new,
			SourceFileTest.new,
		];
		final runner:Runner = new Runner();

		#if instrument
		runner.onComplete.add(_ -> {
			instrument.coverage.Coverage.endCoverage();
		});
		#end

		new DiagnosticsReport(runner);
		for (test in tests) {
			runner.addCase(test());
		}
		runner.run();
	}
}
