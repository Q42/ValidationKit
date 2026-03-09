@testable import ValidationKit
import XCTest

class MessageRuleTests: XCTestCase {
    func testMessageReplacesError() {
        let rule = EmailRule().message("Please enter a valid email")
        let result = rule.validate("not-an-email")

        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errors.count, 1)
        XCTAssertEqual(result.errors.first?.localizedDescription, "Please enter a valid email")
    }

    func testMessagePreservesValidResult() {
        let rule = EmailRule().message("Please enter a valid email")
        let result = rule.validate("test@example.com")

        XCTAssertTrue(result.isValid)
        XCTAssertNotNil(result.value)
    }

    func testMessageOnComposedRule() {
        let rule: AllRule<String> = .all(
            NotEmptyRule().message("Email is required"),
            EmailRule().message("That doesn't look like an email")
        )

        let result = rule.validate("")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errors.count, 2)
        XCTAssertEqual(result.errors[0].localizedDescription, "Email is required")
        XCTAssertEqual(result.errors[1].localizedDescription, "That doesn't look like an email")
    }

    func testMessageOnBuiltInRule() {
        let rule = MinLengthRule(length: 8).message("Password too short")
        let result = rule.validate("abc")

        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errors.first?.localizedDescription, "Password too short")
    }
}
