@testable import ValidationKit
import Testing

struct SelectionTests {
    @Test func anyOf() {
        let rule = AnyOfRule(options: [
            ("a", "Option A"),
            ("b", "Option B"),
            ("c", "Option C"),
        ])

        // Invalid
        #expect(!rule.validate("d").isValid)
        #expect(!rule.validate("").isValid)

        // Valid
        #expect(rule.validate("a").value == "Option A")
        #expect(rule.validate("b").value == "Option B")
        #expect(rule.validate("c").value == "Option C")

        // Error message
        #expect(ValidationError.invalidOption(option: "hello").localizedDescription == "invalid option hello")
    }

    @Test func dotSyntax() {
        let rule: some ValidationRule<String, String> = .anyOf(options: [("x", "X")])
        #expect(rule.validate("x").isValid)
    }
}
