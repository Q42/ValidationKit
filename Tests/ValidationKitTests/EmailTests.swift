@testable import ValidationKit
import XCTest

class EmailTests: XCTestCase {
    let rule = EmailRule()

    func testValidEmailAddresses() {
        XCTAssertTrue(rule.validate("mathijsb+test@q42.nl").isValid)
        XCTAssertTrue(rule.validate("mathijsb@subdomain.q42.nl").isValid)

        // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
        XCTAssertTrue(rule.validate("email@domain.com").isValid, "Valid email")
        XCTAssertTrue(rule.validate("firstname.lastname@domain.com").isValid, "The email contains a dot in the address field")
        XCTAssertTrue(rule.validate("email@subdomain.domain.com").isValid, "The email contains a dot with a subdomain")
        XCTAssertTrue(rule.validate("firstname+lastname@domain.com").isValid, "Plus sign is considered a valid character")
        XCTAssertTrue(rule.validate("email@123.123.123.123").isValid, "The domain is a valid IP address")
        XCTAssertTrue(rule.validate("1234567890@domain.com").isValid, "Digits in the address are valid")
        XCTAssertTrue(rule.validate("email@domain-one.com").isValid, "Dash in the domain name is valid")
        XCTAssertTrue(rule.validate("_______@domain.com").isValid, "Underscore in the address field is valid")
        XCTAssertTrue(rule.validate("email@domain.name").isValid, ".name is a valid Top Level Domain name")
        XCTAssertTrue(rule.validate("email@domain.co.jp").isValid, "Dot in Top Level Domain name also considered valid (use co.jp as an example here)")
        XCTAssertTrue(rule.validate("firstname-lastname@domain.com").isValid, "Dash in the address field is valid")

        // Test cases from ChatGPT
        XCTAssertTrue(rule.validate("example@example.com").isValid, "Standard email format")
        XCTAssertTrue(rule.validate("john.doe@example.co.uk").isValid, "Email with a subdomain")
        XCTAssertTrue(rule.validate("user123@example123.com").isValid, "Email with numbers in the domain name")
        XCTAssertTrue(rule.validate("john_doe+test@example.com").isValid, "Email with special characters in the local part")
        XCTAssertTrue(rule.validate("user@example.io").isValid, "Email with a two-letter top-level domain (TLD)")
        XCTAssertTrue(rule.validate("test-email@example-domain.com").isValid, "Email with a hyphen in the domain name")
        XCTAssertTrue(rule.validate("a@example.com").isValid, "Email with a single-letter local part")
        XCTAssertTrue(rule.validate("thisisaverylongemailaddresswithlotsofcharacters@example.com").isValid, "Email with a long local part and domain name")
        XCTAssertTrue(rule.validate(".test@example.com").isValid, "Email with a dot at the beginning of the local part")
        XCTAssertTrue(rule.validate("test.@example.com").isValid, "Email with a dot at the end of the local part")
    }

    func testInvalidEmailAddresses() {
        XCTAssertFalse(rule.validate("").isValid)
        XCTAssertFalse(rule.validate("foo").isValid)
        XCTAssertFalse(rule.validate("foobarbazquuxwhopper").isValid)

        // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
        XCTAssertFalse(rule.validate("plain address").isValid, "Missing @ sign and domain")
        XCTAssertFalse(rule.validate("#@%^%#$@#$@#.com").isValid, "Garbage")
        XCTAssertFalse(rule.validate("@domain.com").isValid, "Missing username")
        XCTAssertFalse(rule.validate("email.domain.com").isValid, "Missing @")
        XCTAssertFalse(rule.validate("email@domain").isValid, "Missing top-level domain (.com/.net/.org/etc.)")
        XCTAssertFalse(rule.validate("email@-domain.com").isValid, "The leading dash in front of the domain is invalid")
        XCTAssertFalse(rule.validate("email@domain..com").isValid, "Multiple dots in the domain portion is invalid")

        // Test cases from ChatGPT
        XCTAssertFalse(rule.validate("example.com").isValid, "Missing @ symbol")
        XCTAssertFalse(rule.validate("john@.com").isValid, "Email without a domain name")
        XCTAssertFalse(rule.validate("user@example").isValid, "Email without a top-level domain (TLD)")
        XCTAssertFalse(rule.validate("john@example#.com").isValid, "Email with invalid characters in the domain name")
        XCTAssertFalse(rule.validate("@example.com").isValid, "Email without a local part")
        XCTAssertFalse(rule.validate("john_doe@_example.com").isValid, "Email with an underscore at the beginning of the domain name")
        XCTAssertFalse(rule.validate("user@example.").isValid, "Email with a missing domain extension")
    }

    func testDotSyntax() {
        let rule: some ValidationRule<String, String> = .email
        XCTAssertTrue(rule.validate("test@example.com").isValid)
    }
}
