import XCTest
import ValidationKit

class EmailTests: XCTestCase {
  var validator: Validator<String, String>!

  override func setUpWithError() throws {
    validator = .email
  }

  func testValidEmailAddresses() throws {
    XCTAssertTrue(validator.validate(input: "mathijsb+test@q42.nl").isValid)
    XCTAssertTrue(validator.validate(input: "mathijsb@subdomain.q42.nl").isValid)

    // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
    XCTAssertTrue(validator.validate(input: "email@domain.com").isValid, "Valid email")
    XCTAssertTrue(validator.validate(input: "firstname.lastname@domain.com").isValid, "The email contains a dot in the address field")
    XCTAssertTrue(validator.validate(input: "email@subdomain.domain.com").isValid, "The email contains a dot with a subdomain")
    XCTAssertTrue(validator.validate(input: "firstname+lastname@domain.com").isValid, "Plus sign is considered a valid character")
    XCTAssertTrue(validator.validate(input: "email@123.123.123.123").isValid, "The domain is a valid IP address")
    XCTAssertTrue(validator.validate(input: "1234567890@domain.com").isValid, "Digits in the address are valid")
    XCTAssertTrue(validator.validate(input: "email@domain-one.com").isValid, "Dash in the domain name is valid")
    XCTAssertTrue(validator.validate(input: "_______@domain.com").isValid, "Underscore in the address field is valid")
    XCTAssertTrue(validator.validate(input: "email@domain.name").isValid, ".name is a valid Top Level Domain name")
    XCTAssertTrue(validator.validate(input: "email@domain.co.jp").isValid, "Dot in Top Level Domain name also considered valid (use co.jp as an example here)")
    XCTAssertTrue(validator.validate(input: "firstname-lastname@domain.com").isValid, "Dash in the address field is valid")

    // These cases are currently not considered valid, but they should be
    // XCTAssertTrue(validator.validate(input: "email@[123.123.123.123]").isValid, "A square bracket around the IP address is considered valid")
    // XCTAssertTrue(validator.validate(input: "“email”@domain.com").isValid, "Quotes around email are considered valid")
  }

  func testInvalidEmailAddresses() throws {
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "foo").isValid)
    XCTAssertFalse(validator.validate(input: "foobarbazquuxwhopper").isValid)

    // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
    XCTAssertFalse(validator.validate(input: "plain address").isValid, "Missing @ sign and domain")
    XCTAssertFalse(validator.validate(input: "#@%^%#$@#$@#.com").isValid, "Garbage")
    XCTAssertFalse(validator.validate(input: "@domain.com").isValid, "Missing username")
    XCTAssertFalse(validator.validate(input: "email.domain.com").isValid, "Missing @")
    XCTAssertFalse(validator.validate(input: "email@domain").isValid, "Missing top-level domain (.com/.net/.org/etc.)")
    XCTAssertFalse(validator.validate(input: "email@-domain.com").isValid, "The leading dash in front of the domain is invalid")
    XCTAssertFalse(validator.validate(input: "email@domain..com").isValid, "Multiple dots in the domain portion is invalid")

    // These cases are currently considered valid, but they should not be
    // XCTAssertFalse(validator.validate(input: "email.@domain.com").isValid, "Trailing dot in address is not allowed")
    // XCTAssertFalse(validator.validate(input: "Joe Smith <email@domain.com>").isValid, "Encoded HTML within an email is invalid")
    // XCTAssertFalse(validator.validate(input: "email@domain@domain.com").isValid, "Two @ sign")
    // XCTAssertFalse(validator.validate(input: ".email@domain.com").isValid, "The leading dot in the address is not allowed")
    // XCTAssertFalse(validator.validate(input: "email..email@domain.com").isValid, "Multiple dots")
    // XCTAssertFalse(validator.validate(input: "あいうえお@domain.com").isValid, "Unicode char as address")
    // XCTAssertFalse(validator.validate(input: "email@domain.com (Joe Smith)").isValid, "Text followed email is not allowed")
    // XCTAssertFalse(validator.validate(input: "email@domain.web").isValid, ".web is not a valid top-level domain")
    // XCTAssertFalse(validator.validate(input: "email@111.222.333.44444").isValid, "Invalid IP format")
  }
}
