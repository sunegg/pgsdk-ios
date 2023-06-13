import XCTest

import pgsdkTests

var tests = [XCTestCaseEntry]()
tests += pgsdkTests.allTests()
XCTMain(tests)
