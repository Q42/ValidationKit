@testable import ValidationKit
import Testing

struct EmailTests {
    let rule = EmailRule()

    @Test(arguments: [
        "mathijsb+test@q42.nl",
        "mathijsb@subdomain.q42.nl",
        "email@domain.com",
        "firstname.lastname@domain.com",
        "email@subdomain.domain.com",
        "firstname+lastname@domain.com",
        "email@123.123.123.123",
        "1234567890@domain.com",
        "email@domain-one.com",
        "_______@domain.com",
        "email@domain.name",
        "email@domain.co.jp",
        "firstname-lastname@domain.com",
        "example@example.com",
        "john.doe@example.co.uk",
        "user123@example123.com",
        "john_doe+test@example.com",
        "user@example.io",
        "test-email@example-domain.com",
        "a@example.com",
        "thisisaverylongemailaddresswithlotsofcharacters@example.com",
        ".test@example.com",
        "test.@example.com",
    ])
    func validEmailAddresses(email: String) {
        #expect(rule.validate(email).isValid)
    }

    @Test(arguments: [
        "",
        "foo",
        "foobarbazquuxwhopper",
        "plain address",
        "#@%^%#$@#$@#.com",
        "@domain.com",
        "email.domain.com",
        "email@domain",
        "email@-domain.com",
        "email@domain..com",
        "example.com",
        "john@.com",
        "user@example",
        "john@example#.com",
        "@example.com",
        "john_doe@_example.com",
        "user@example.",
    ])
    func invalidEmailAddresses(email: String) {
        #expect(!rule.validate(email).isValid)
    }

    @Test func dotSyntax() {
        let rule: some ValidationRule<String, String> = .email
        #expect(rule.validate("test@example.com").isValid)
    }
}
