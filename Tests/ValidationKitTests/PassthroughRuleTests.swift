@testable import ValidationKit
import XCTest

class PassthroughRuleTests: XCTestCase {
    func testPassthroughAlwaysPasses() {
        let rule = PassthroughRule<String>()

        XCTAssertTrue(rule.validate("").isValid)
        XCTAssertTrue(rule.validate("anything").isValid)
        XCTAssertEqual(rule.validate("hello").value, "hello")
    }

    func testDotSyntax() {
        let rule: PassthroughRule<String> = .none
        XCTAssertTrue(rule.validate("anything").isValid)
    }
}
