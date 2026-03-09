@testable import ValidationKit
import XCTest

class AcceptedTests: XCTestCase {
    func testAccepted() {
        let rule = AcceptedRule()

        XCTAssertFalse(rule.validate(false).isValid)
        XCTAssertTrue(rule.validate(true).isValid)
        XCTAssertEqual(rule.validate(true).value, true)
    }

    func testDotSyntax() {
        let rule: some ValidationRule<Bool, Bool> = .accepted
        XCTAssertTrue(rule.validate(true).isValid)
    }
}
