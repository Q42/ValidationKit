@testable import ValidationKit
import Testing

struct StringTests {
    @Test func hasPrefix() {
        let rule = HasPrefixRule(prefix: "42")

        // Invalid
        #expect(!rule.validate("").isValid)
        #expect(!rule.validate("hello").isValid)

        // Valid
        #expect(rule.validate("4200").value == "4200")
        #expect(rule.validate("42").value == "42")

        // Error message
        #expect(ValidationError.invalidPrefix(prefix: "hoi").localizedDescription == "must start with hoi")
    }

    @Test func dotSyntax() {
        let rule: some ValidationRule<String, String> = .hasPrefix("AB")
        #expect(rule.validate("ABC").isValid)
    }
}
