@testable import ValidationKit
import XCTest

class EmptyTests: XCTestCase {
    func testIsEmpty() {
        let rule = IsEmptyRule()

        // Valid
        XCTAssertEqual(rule.validate("").value, "")
        XCTAssertEqual(rule.validate(" ").value, "")

        // Invalid
        XCTAssertFalse(rule.validate("eerste etage").isValid)
        XCTAssertFalse(rule.validate("F").isValid)
    }

    func testNotEmpty() {
        let rule = NotEmptyRule()

        // Valid
        XCTAssertEqual(rule.validate("eerste etage").value, "eerste etage")
        XCTAssertEqual(rule.validate(" F").value, "F")
        XCTAssertEqual(rule.validate("F ").value, "F")

        // Invalid
        XCTAssertFalse(rule.validate("").isValid)
        XCTAssertFalse(rule.validate(" ").isValid)
    }

    func testDotSyntax() {
        let isEmpty: some ValidationRule<String, String> = .isEmpty
        XCTAssertTrue(isEmpty.validate("").isValid)

        let notEmpty: some ValidationRule<String, String> = .notEmpty
        XCTAssertTrue(notEmpty.validate("hello").isValid)
    }
}
