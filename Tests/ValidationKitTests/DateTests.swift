import Foundation
@testable import ValidationKit
import Testing

struct DateTests {
    @Test func isDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"

        let rule = DateRule(formatter: dateFormatter)

        // Valid
        #expect(rule.validate("2021-03-28 12:11:25").isValid)

        // Invalid
        #expect(!rule.validate("2021-03-28").isValid)
        #expect(!rule.validate("12:11:25").isValid)
        #expect(!rule.validate("test").isValid)
    }

    @Test func dotSyntax() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let rule: some ValidationRule<String, Date> = .isDate(formatter: dateFormatter)
        #expect(rule.validate("2024-01-01").isValid)
    }
}
