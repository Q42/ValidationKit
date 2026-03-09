@testable import ValidationKit
import Testing

struct AcceptedTests {
    @Test func accepted() {
        let rule = AcceptedRule()

        #expect(!rule.validate(false).isValid)
        #expect(rule.validate(true).isValid)
        #expect(rule.validate(true).value == true)
    }

    @Test func dotSyntax() {
        let rule: some ValidationRule<Bool, Bool> = .accepted
        #expect(rule.validate(true).isValid)
    }
}
