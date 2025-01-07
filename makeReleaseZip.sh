#!/bin/bash -e

npm install
npx lix download

npx haxe build.hxml
npx haxe test.hxml
npx haxe testCoverage.hxml

rm -f simple_lcov.zip
zip -9 -r -q simple_lcov.zip src haxelib.json README.md CHANGELOG.md LICENSE.md
