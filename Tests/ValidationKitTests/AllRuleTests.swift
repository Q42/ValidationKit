@testable import ValidationKit
import XCTest

class AllRuleTests: XCTestCase {
    func testAllRuleCollectsMultipleErrors() {
        let rule = AllRule<String>(rules: [
            NotEmptyRule(),
            MinLengthRule(length: 8),
            EmailRule(),
        ])

        let result = rule.validate("")
        XCTAssertFalse(result.isValid)
        // NotEmpty, MinLength, and Email should all fail
        XCTAssertEqual(result.errors.count, 3)
    }

    func testAllRulePartialErrors() {
        let rule = AllRule<String>(rules: [
            NotEmptyRule(),
            MinLengthRule(length: 8),
            EmailRule(),
        ])

        let result = rule.validate("ab")
        XCTAssertFalse(result.isValid)
        // NotEmpty passes, MinLength fails, Email fails
        XCTAssertEqual(result.errors.count, 2)
    }

    func testAllRuleAllPass() {
        let rule = AllRule<String>(rules: [
            NotEmptyRule(),
            MinLengthRule(length: 3),
        ])

        let result = rule.validate("hello")
        XCTAssertTrue(result.isValid)
        XCTAssertEqual(result.value, "hello")
        XCTAssertTrue(result.errors.isEmpty)
    }

    func testAllRuleDotSyntax() {
        let rule: AllRule<String> = .all(.notEmpty, .minLength(8), .email)

        let result = rule.validate("ab")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errors.count, 2)
    }

    func testAllRuleEmptyRules() {
        let rule = AllRule<String>(rules: [])
        XCTAssertTrue(rule.validate("anything").isValid)
    }
}
