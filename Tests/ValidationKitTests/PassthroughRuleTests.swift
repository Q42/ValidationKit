@testable import ValidationKit
import Testing

struct PassthroughRuleTests {
    @Test func passthroughAlwaysPasses() {
        let rule = PassthroughRule<String>()

        #expect(rule.validate("").isValid)
        #expect(rule.validate("anything").isValid)
        #expect(rule.validate("hello").value == "hello")
    }

    @Test func dotSyntax() {
        let rule: PassthroughRule<String> = .none
        #expect(rule.validate("anything").isValid)
    }
}
