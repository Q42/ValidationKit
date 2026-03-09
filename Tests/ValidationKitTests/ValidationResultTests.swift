@testable import ValidationKit
import XCTest

class ValidationResultTests: XCTestCase {
    func testValidResult() {
        let result = ValidationResult<String>.valid("hello")

        XCTAssertTrue(result.isValid)
        XCTAssertEqual(result.value, "hello")
        XCTAssertTrue(result.errors.isEmpty)
    }

    func testInvalidResultSingleError() {
        let result = ValidationResult<String>.invalid(.notEmpty)

        XCTAssertFalse(result.isValid)
        XCTAssertNil(result.value)
        XCTAssertEqual(result.errors.count, 1)
        XCTAssertEqual(result.errors.first, .notEmpty)
    }

    func testInvalidResultMultipleErrors() {
        let result = ValidationResult<String>.invalid([.notEmpty, .invalidEmail])

        XCTAssertFalse(result.isValid)
        XCTAssertNil(result.value)
        XCTAssertEqual(result.errors.count, 2)
    }

    func testConvenienceSingleError() {
        let result = ValidationResult<String>.invalid(.invalidEmail)

        XCTAssertEqual(result.errors.count, 1)
        XCTAssertEqual(result.errors.first, .invalidEmail)
    }
}
