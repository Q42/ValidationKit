@testable import ValidationKit
import XCTest

class LengthTests: XCTestCase {
    func testMinLength() {
        let rule = MinLengthRule(length: 5)

        // Invalid
        XCTAssertFalse(rule.validate("").isValid)
        XCTAssertFalse(rule.validate("hoi").isValid)
        XCTAssertNil(rule.validate("").value)

        // Valid
        XCTAssertTrue(rule.validate("hello").isValid)
        XCTAssertTrue(rule.validate("this is a test").isValid)

        // Error message
        XCTAssertEqual(ValidationError.tooShort(minLength: 5).localizedDescription, "must be 5 or more characters long")
    }

    func testMaxLength() {
        let rule = MaxLengthRule(length: 5)

        // Invalid
        XCTAssertFalse(rule.validate("hello world").isValid)
        XCTAssertFalse(rule.validate("this is a test").isValid)

        // Valid
        XCTAssertTrue(rule.validate("hello").isValid)
        XCTAssertTrue(rule.validate("123").isValid)

        // Error message
        XCTAssertEqual(ValidationError.tooLong(maxLength: 5).localizedDescription, "must be 5 or fewer characters long")
    }

    func testExactLength() {
        let rule = ExactLengthRule(length: 10)

        // Invalid
        XCTAssertFalse(rule.validate("").isValid)
        XCTAssertFalse(rule.validate("hello").isValid)
        XCTAssertFalse(rule.validate("this is only a test").isValid)

        // Valid
        XCTAssertTrue(rule.validate("helloworld").isValid)

        // Error message
        XCTAssertEqual(ValidationError.notExactLength(exactLength: 5).localizedDescription, "must be exactly 5 characters long")
    }

    func testDotSyntax() {
        let min: some ValidationRule<String, String> = .minLength(3)
        XCTAssertTrue(min.validate("hello").isValid)

        let max: some ValidationRule<String, String> = .maxLength(3)
        XCTAssertTrue(max.validate("hi").isValid)

        let exact: some ValidationRule<String, String> = .exactLength(3)
        XCTAssertTrue(exact.validate("hey").isValid)
    }
}
