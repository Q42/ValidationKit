@testable import ValidationKit
import Testing

struct AllRuleTests {
    @Test func collectsMultipleErrors() {
        let rule = AllRule<String>(rules: [
            NotEmptyRule(),
            MinLengthRule(length: 8),
            EmailRule(),
        ])

        let result = rule.validate("")
        #expect(!result.isValid)
        // NotEmpty, MinLength, and Email should all fail
        #expect(result.errors.count == 3)
    }

    @Test func partialErrors() {
        let rule = AllRule<String>(rules: [
            NotEmptyRule(),
            MinLengthRule(length: 8),
            EmailRule(),
        ])

        let result = rule.validate("ab")
        #expect(!result.isValid)
        // NotEmpty passes, MinLength fails, Email fails
        #expect(result.errors.count == 2)
    }

    @Test func allPass() {
        let rule = AllRule<String>(rules: [
            NotEmptyRule(),
            MinLengthRule(length: 3),
        ])

        let result = rule.validate("hello")
        #expect(result.isValid)
        #expect(result.value == "hello")
        #expect(result.errors.isEmpty)
    }

    @Test func dotSyntax() {
        let rule: AllRule<String> = .all(.notEmpty, .minLength(8), .email)

        let result = rule.validate("ab")
        #expect(!result.isValid)
        #expect(result.errors.count == 2)
    }

    @Test func emptyRules() {
        let rule = AllRule<String>(rules: [])
        #expect(rule.validate("anything").isValid)
    }
}
