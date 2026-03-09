@testable import ValidationKit
import XCTest

class SelectionTests: XCTestCase {
    func testAnyOf() {
        let rule = AnyOfRule(options: [
            ("a", "Option A"),
            ("b", "Option B"),
            ("c", "Option C"),
        ])

        // Invalid
        XCTAssertFalse(rule.validate("d").isValid)
        XCTAssertFalse(rule.validate("").isValid)

        // Valid
        XCTAssertEqual(rule.validate("a").value, "Option A")
        XCTAssertEqual(rule.validate("b").value, "Option B")
        XCTAssertEqual(rule.validate("c").value, "Option C")

        // Error message
        XCTAssertEqual(ValidationError.invalidOption(option: "hello").localizedDescription, "invalid option hello")
    }

    func testDotSyntax() {
        let rule: some ValidationRule<String, String> = .anyOf(options: [("x", "X")])
        XCTAssertTrue(rule.validate("x").isValid)
    }
}
