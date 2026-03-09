@testable import ValidationKit
import Testing

struct EmptyTests {
    @Test func isEmpty() {
        let rule = IsEmptyRule()

        // Valid
        #expect(rule.validate("").value == "")
        #expect(rule.validate(" ").value == "")

        // Invalid
        #expect(!rule.validate("eerste etage").isValid)
        #expect(!rule.validate("F").isValid)
    }

    @Test func notEmpty() {
        let rule = NotEmptyRule()

        // Valid
        #expect(rule.validate("eerste etage").value == "eerste etage")
        #expect(rule.validate(" F").value == "F")
        #expect(rule.validate("F ").value == "F")

        // Invalid
        #expect(!rule.validate("").isValid)
        #expect(!rule.validate(" ").isValid)
    }

    @Test func dotSyntax() {
        let isEmpty: some ValidationRule<String, String> = .isEmpty
        #expect(isEmpty.validate("").isValid)

        let notEmpty: some ValidationRule<String, String> = .notEmpty
        #expect(notEmpty.validate("hello").isValid)
    }
}
