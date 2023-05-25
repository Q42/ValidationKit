import XCTest
import ValidationKit

class EmailTests: XCTestCase {
  func testValidEmailAddresses() {
    let validator = Validator<String, String>.email

    // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
    XCTAssertTrue(validator.validate(input: "email@domain.com").isValid, "Valid email")
    XCTAssertTrue(validator.validate(input: "firstname.lastname@domain.com").isValid, "The email contains a dot in the address field")
    XCTAssertTrue(validator.validate(input: "email@subdomain.domain.com").isValid, "The email contains a dot with a subdomain")
    XCTAssertTrue(validator.validate(input: "firstname+lastname@domain.com").isValid, "Plus sign is considered a valid character")
    XCTAssertTrue(validator.validate(input: "email@123.123.123.123").isValid, "The domain is a valid IP address")
    XCTAssertTrue(validator.validate(input: "email@[123.123.123.123]").isValid, "A square bracket around the IP address is considered valid")
    XCTAssertTrue(validator.validate(input: "“email”@domain.com").isValid, "Quotes around email are considered valid")
    XCTAssertTrue(validator.validate(input: "1234567890@domain.com").isValid, "Digits in the address are valid")
    XCTAssertTrue(validator.validate(input: "email@domain-one.com").isValid, "Dash in the domain name is valid")
    XCTAssertTrue(validator.validate(input: "_______@domain.com").isValid, "Underscore in the address field is valid")
    XCTAssertTrue(validator.validate(input: "email@domain.name").isValid, ".name is a valid Top Level Domain name")
    XCTAssertTrue(validator.validate(input: "email@domain.co.jp").isValid, "Dot in Top Level Domain name also considered valid (use co.jp as an example here)")
    XCTAssertTrue(validator.validate(input: "firstname-lastname@domain.com").isValid, "Dash in the address field is valid")

    // Test cases from ChatGPT
    XCTAssertTrue(validator.validate(input: "example@example.com").isValid, "Standard email format")
    XCTAssertTrue(validator.validate(input: "john.doe@example.co.uk").isValid, "Email with a subdomain")
    XCTAssertTrue(validator.validate(input: "user123@example123.com").isValid, "Email with numbers in the domain name")
    XCTAssertTrue(validator.validate(input: "john_doe+test@example.com").isValid, "Email with special characters in the local part")
    XCTAssertTrue(validator.validate(input: "user@example.io").isValid, "Email with a two-letter top-level domain (TLD)")
    XCTAssertTrue(validator.validate(input: "test-email@example-domain.com").isValid, "Email with a hyphen in the domain name")
    XCTAssertTrue(validator.validate(input: "a@example.com").isValid, "Email with a single-letter local part")
    XCTAssertTrue(validator.validate(input: "thisisaverylongemailaddresswithlotsofcharacters@example.com").isValid, "Email with a long local part and domain name")
    XCTAssertTrue(validator.validate(input: ".test@example.com").isValid, "Email with a dot at the beginning of the local part")
    XCTAssertTrue(validator.validate(input: "test.@example.com").isValid, "Email with a dot at the end of the local part")
  }

  func testInvalidEmailAddresses() {
    let validator = Validator<String, String>.email

    XCTAssertFalse(validator.validate(input: "@#@@##@%^%#$@#$@#.com").isValid)

    // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
    XCTAssertFalse(validator.validate(input: "plain address").isValid, "Missing @ sign and domain")
    XCTAssertFalse(validator.validate(input: "#@%^%#$@#$@#.com").isValid, "Garbage")
    XCTAssertFalse(validator.validate(input: "@domain.com").isValid, "Missing username")
    XCTAssertFalse(validator.validate(input: "Joe Smith <email@domain.com>").isValid, "Encoded HTML within an email is invalid")
    XCTAssertFalse(validator.validate(input: "email.domain.com").isValid, "Missing @")
    XCTAssertFalse(validator.validate(input: "email@domain@domain.com").isValid, "Two @ sign")
    XCTAssertFalse(validator.validate(input: ".email@domain.com").isValid, "The leading dot in the address is not allowed")
    XCTAssertFalse(validator.validate(input: "email.@domain.com").isValid, "Trailing dot in address is not allowed")
    XCTAssertFalse(validator.validate(input: "email..email@domain.com").isValid, "Multiple dots")
    XCTAssertFalse(validator.validate(input: "あいうえお@domain.com").isValid, "Unicode char as address")
    XCTAssertFalse(validator.validate(input: "email@domain.com (Joe Smith)").isValid, "Text followed email is not allowed")
    XCTAssertFalse(validator.validate(input: "email@domain").isValid, "Missing top-level domain (.com/.net/.org/etc.)")
    XCTAssertFalse(validator.validate(input: "email@-domain.com").isValid, "The leading dash in front of the domain is invalid")
    XCTAssertFalse(validator.validate(input: "email@domain.web").isValid, ".web is not a valid top-level domain")
    XCTAssertFalse(validator.validate(input: "email@111.222.333.44444").isValid, "Invalid IP format")
    XCTAssertFalse(validator.validate(input: "email@domain..com").isValid, "Multiple dots in the domain portion is invalid")

    // Test cases from ChatGPT
    XCTAssertFalse(validator.validate(input: "example.com").isValid, "Missing @ symbol")
    XCTAssertFalse(validator.validate(input: "john@.com").isValid, "Email without a domain name")
    XCTAssertFalse(validator.validate(input: "user@example").isValid, "Email without a top-level domain (TLD)")
    XCTAssertFalse(validator.validate(input: "john@doe@example.com").isValid, "Email with multiple @ symbols")
    XCTAssertFalse(validator.validate(input: "john doe@example.com").isValid, "Email with a space character")
    XCTAssertFalse(validator.validate(input: "john@example#.com").isValid, "Email with invalid characters in the domain name")
    XCTAssertFalse(validator.validate(input: "@example.com").isValid, "Email without a local part")
    XCTAssertFalse(validator.validate(input: "john..doe@example.com").isValid, "Email with consecutive dots in the local part")
    XCTAssertFalse(validator.validate(input: "john_doe@_example.com").isValid, "Email with an underscore at the beginning of the domain name")
    XCTAssertFalse(validator.validate(input: "user@example.").isValid, "Email with a missing domain extension")
  }
}
