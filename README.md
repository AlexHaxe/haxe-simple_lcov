# simple_lcov library

simple_lcov is a fork from <https://github.com/cedx/lcov.hx> with some modifcations:

- no dependencies required when using simple_lcov

## usage

```haxe
switch (Report.parse(File.getContent("lcov.info"))) {
  case Failure(error):
    trace(error.message);
  case Success(report):
    trace('The coverage report contains ${report.sourceFiles.length} source files:');
    // TODO: use `report`
}
```
