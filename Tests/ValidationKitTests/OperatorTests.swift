import Foundation
@testable import ValidationKit
import Testing

struct OperatorTests {
    @Test func chainedOperator() {
        let rule = NotEmptyRule() && MaxLengthRule(length: 5)

        // Valid
        #expect(rule.validate("abc").isValid)
        #expect(rule.validate("hello").isValid)

        // Invalid - empty
        #expect(!rule.validate("").isValid)

        // Invalid - too long
        #expect(!rule.validate("abcdef").isValid)
    }

    @Test func chainedShortCircuits() {
        let rule = NotEmptyRule() && EmailRule()
        let result = rule.validate("")

        // Should short-circuit at NotEmptyRule, not produce email error
        #expect(!result.isValid)
        #expect(result.errors.count == 1)
        #expect(result.errors.first == .notEmpty)
    }

    @Test func eitherOperator() {
        let rule = IsEmptyRule() || NotEmptyRule() && MaxLengthRule(length: 5)

        // Valid
        #expect(rule.validate("").isValid)
        #expect(rule.validate("abc").isValid)

        // Invalid
        #expect(!rule.validate("abcdef").isValid)
    }

    @Test func typeTransformingChain() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let rule = NotEmptyRule() && DateRule(formatter: dateFormatter)

        // Valid
        #expect(rule.validate("2024-01-01").isValid)
        #expect(rule.validate("2024-01-01").value != nil)

        // Invalid
        #expect(!rule.validate("").isValid)
        #expect(!rule.validate("not a date").isValid)
    }
}
