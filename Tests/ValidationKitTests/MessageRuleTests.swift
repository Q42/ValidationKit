@testable import ValidationKit
import Testing

struct MessageRuleTests {
    @Test func messageReplacesError() {
        let rule = EmailRule().message("Please enter a valid email")
        let result = rule.validate("not-an-email")

        #expect(!result.isValid)
        #expect(result.errors.count == 1)
        #expect(result.errors.first?.localizedDescription == "Please enter a valid email")
    }

    @Test func messagePreservesValidResult() {
        let rule = EmailRule().message("Please enter a valid email")
        let result = rule.validate("test@example.com")

        #expect(result.isValid)
        #expect(result.value != nil)
    }

    @Test func messageOnComposedRule() {
        let rule: AllRule<String> = .all(
            NotEmptyRule().message("Email is required"),
            EmailRule().message("That doesn't look like an email")
        )

        let result = rule.validate("")
        #expect(!result.isValid)
        #expect(result.errors.count == 2)
        #expect(result.errors[0].localizedDescription == "Email is required")
        #expect(result.errors[1].localizedDescription == "That doesn't look like an email")
    }

    @Test func messageOnBuiltInRule() {
        let rule = MinLengthRule(length: 8).message("Password too short")
        let result = rule.validate("abc")

        #expect(!result.isValid)
        #expect(result.errors.first?.localizedDescription == "Password too short")
    }
}
