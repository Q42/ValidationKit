@testable import ValidationKit
import XCTest

class OperatorTests: XCTestCase {
    func testChainedOperator() {
        let rule = NotEmptyRule() && MaxLengthRule(length: 5)

        // Valid
        XCTAssertTrue(rule.validate("abc").isValid)
        XCTAssertTrue(rule.validate("hello").isValid)

        // Invalid - empty
        XCTAssertFalse(rule.validate("").isValid)

        // Invalid - too long
        XCTAssertFalse(rule.validate("abcdef").isValid)
    }

    func testChainedShortCircuits() {
        let rule = NotEmptyRule() && EmailRule()
        let result = rule.validate("")

        // Should short-circuit at NotEmptyRule, not produce email error
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errors.count, 1)
        XCTAssertEqual(result.errors.first, .notEmpty)
    }

    func testEitherOperator() {
        let rule = IsEmptyRule() || NotEmptyRule() && MaxLengthRule(length: 5)

        // Valid
        XCTAssertTrue(rule.validate("").isValid)
        XCTAssertTrue(rule.validate("abc").isValid)

        // Invalid
        XCTAssertFalse(rule.validate("abcdef").isValid)
    }

    func testTypeTransformingChain() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let rule = NotEmptyRule() && DateRule(formatter: dateFormatter)

        // Valid
        XCTAssertTrue(rule.validate("2024-01-01").isValid)
        XCTAssertNotNil(rule.validate("2024-01-01").value)

        // Invalid
        XCTAssertFalse(rule.validate("").isValid)
        XCTAssertFalse(rule.validate("not a date").isValid)
    }
}
