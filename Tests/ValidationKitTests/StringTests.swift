@testable import ValidationKit
import XCTest

class StringTests: XCTestCase {
    func testHasPrefix() {
        let rule = HasPrefixRule(prefix: "42")

        // Invalid
        XCTAssertFalse(rule.validate("").isValid)
        XCTAssertFalse(rule.validate("hello").isValid)

        // Valid
        XCTAssertEqual(rule.validate("4200").value, "4200")
        XCTAssertEqual(rule.validate("42").value, "42")

        // Error message
        XCTAssertEqual(ValidationError.invalidPrefix(prefix: "hoi").localizedDescription, "must start with hoi")
    }

    func testDotSyntax() {
        let rule: some ValidationRule<String, String> = .hasPrefix("AB")
        XCTAssertTrue(rule.validate("ABC").isValid)
    }
}
