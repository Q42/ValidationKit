@testable import ValidationKit
import XCTest

class DateTests: XCTestCase {
    func testIsDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"

        let rule = DateRule(formatter: dateFormatter)

        // Valid
        XCTAssertTrue(rule.validate("2021-03-28 12:11:25").isValid)

        // Invalid
        XCTAssertFalse(rule.validate("2021-03-28").isValid)
        XCTAssertFalse(rule.validate("12:11:25").isValid)
        XCTAssertFalse(rule.validate("test").isValid)
    }

    func testDotSyntax() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let rule: some ValidationRule<String, Date> = .isDate(formatter: dateFormatter)
        XCTAssertTrue(rule.validate("2024-01-01").isValid)
    }
}
