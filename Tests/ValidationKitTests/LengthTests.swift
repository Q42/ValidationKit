@testable import ValidationKit
import Testing

struct LengthTests {
    @Test func minLength() {
        let rule = MinLengthRule(length: 5)

        // Invalid
        #expect(!rule.validate("").isValid)
        #expect(!rule.validate("hoi").isValid)
        #expect(rule.validate("").value == nil)

        // Valid
        #expect(rule.validate("hello").isValid)
        #expect(rule.validate("this is a test").isValid)

        // Error message
        #expect(ValidationError.tooShort(minLength: 5).localizedDescription == "must be 5 or more characters long")
    }

    @Test func maxLength() {
        let rule = MaxLengthRule(length: 5)

        // Invalid
        #expect(!rule.validate("hello world").isValid)
        #expect(!rule.validate("this is a test").isValid)

        // Valid
        #expect(rule.validate("hello").isValid)
        #expect(rule.validate("123").isValid)

        // Error message
        #expect(ValidationError.tooLong(maxLength: 5).localizedDescription == "must be 5 or fewer characters long")
    }

    @Test func exactLength() {
        let rule = ExactLengthRule(length: 10)

        // Invalid
        #expect(!rule.validate("").isValid)
        #expect(!rule.validate("hello").isValid)
        #expect(!rule.validate("this is only a test").isValid)

        // Valid
        #expect(rule.validate("helloworld").isValid)

        // Error message
        #expect(ValidationError.notExactLength(exactLength: 5).localizedDescription == "must be exactly 5 characters long")
    }

    @Test func dotSyntax() {
        let min: some ValidationRule<String, String> = .minLength(3)
        #expect(min.validate("hello").isValid)

        let max: some ValidationRule<String, String> = .maxLength(3)
        #expect(max.validate("hi").isValid)

        let exact: some ValidationRule<String, String> = .exactLength(3)
        #expect(exact.validate("hey").isValid)
    }
}
