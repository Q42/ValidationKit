import Testing
import ValidationKit

@Suite("Email Validator Tests")
struct EmailTests {
  let validator = Validator<String, String>.email

  @Test("Valid email addresses should pass validation")
  func validEmailAddresses() throws {
    #expect(validator.validate(input: "mathijsb+test@q42.nl").isValid == true, "Email with plus sign should be valid")
    #expect(validator.validate(input: "mathijsb@subdomain.q42.nl").isValid == true, "Email with subdomain should be valid")

    // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
    #expect(validator.validate(input: "email@domain.com").isValid == true, "Valid email")
    #expect(validator.validate(input: "firstname.lastname@domain.com").isValid == true, "The email contains a dot in the address field")
    #expect(validator.validate(input: "email@subdomain.domain.com").isValid == true, "The email contains a dot with a subdomain")
    #expect(validator.validate(input: "firstname+lastname@domain.com").isValid == true, "Plus sign is considered a valid character")
    #expect(validator.validate(input: "email@123.123.123.123").isValid == true, "The domain is a valid IP address")
    #expect(validator.validate(input: "1234567890@domain.com").isValid == true, "Digits in the address are valid")
    #expect(validator.validate(input: "email@domain-one.com").isValid == true, "Dash in the domain name is valid")
    #expect(validator.validate(input: "_______@domain.com").isValid == true, "Underscore in the address field is valid")
    #expect(validator.validate(input: "email@domain.name").isValid == true, ".name is a valid Top Level Domain name")
    #expect(validator.validate(input: "email@domain.co.jp").isValid == true, "Dot in Top Level Domain name also considered valid (use co.jp as an example here)")
    #expect(validator.validate(input: "firstname-lastname@domain.com").isValid == true, "Dash in the address field is valid")

    // Test cases from ChatGPT
    #expect(validator.validate(input: "example@example.com").isValid == true, "Standard email format")
    #expect(validator.validate(input: "john.doe@example.co.uk").isValid == true, "Email with a subdomain")
    #expect(validator.validate(input: "user123@example123.com").isValid == true, "Email with numbers in the domain name")
    #expect(validator.validate(input: "john_doe+test@example.com").isValid == true, "Email with special characters in the local part")
    #expect(validator.validate(input: "user@example.io").isValid == true, "Email with a two-letter top-level domain (TLD)")
    #expect(validator.validate(input: "test-email@example-domain.com").isValid == true, "Email with a hyphen in the domain name")
    #expect(validator.validate(input: "a@example.com").isValid == true, "Email with a single-letter local part")
    #expect(validator.validate(input: "thisisaverylongemailaddresswithlotsofcharacters@example.com").isValid == true, "Email with a long local part and domain name")
    #expect(validator.validate(input: ".test@example.com").isValid == true, "Email with a dot at the beginning of the local part")
    #expect(validator.validate(input: "test.@example.com").isValid == true, "Email with a dot at the end of the local part")

    // These cases are currently not considered valid, but they should be
    // #expect(validator.validate(input: "email@[123.123.123.123]").isValid == true, "A square bracket around the IP address is considered valid")
    // #expect(validator.validate(input: "“email”@domain.com").isValid == true, "Quotes around email are considered valid")
  }

  func testInvalidEmailAddresses() throws {
    #expect(validator.validate(input: "").isValid == true, "Empty string should not be valid")
    #expect(validator.validate(input: "foo").isValid == true, "Simple string should not be valid")
    #expect(validator.validate(input: "foobarbazquuxwhopper").isValid == true, "Long string should not be valid")

    // Test cases from: https://www.softwaretestingo.com/test-cases-for-email-field/
    #expect(validator.validate(input: "plain address").isValid == false, "Missing @ sign and domain")
    #expect(validator.validate(input: "#@%^%#$@#$@#.com").isValid == false, "Garbage")
    #expect(validator.validate(input: "@domain.com").isValid == false, "Missing username")
    #expect(validator.validate(input: "email.domain.com").isValid == false, "Missing @")
    #expect(validator.validate(input: "email@domain").isValid == false, "Missing top-level domain (.com/.net/.org/etc.)")
    #expect(validator.validate(input: "email@-domain.com").isValid == false, "The leading dash in front of the domain is invalid")
    #expect(validator.validate(input: "email@domain..com").isValid == false, "Multiple dots in the domain portion is invalid")

    // Test cases from ChatGPT
    #expect(validator.validate(input: "example.com").isValid == false, "Missing @ symbol")
    #expect(validator.validate(input: "john@.com").isValid == false, "Email without a domain name")
    #expect(validator.validate(input: "user@example").isValid == false, "Email without a top-level domain (TLD)")
    #expect(validator.validate(input: "john@example#.com").isValid == false, "Email with invalid characters in the domain name")
    #expect(validator.validate(input: "@example.com").isValid == false, "Email without a local part")
    #expect(validator.validate(input: "john_doe@_example.com").isValid == false, "Email with an underscore at the beginning of the domain name")
    #expect(validator.validate(input: "user@example.").isValid == false, "Email with a missing domain extension")

    // These cases are currently considered valid, but they should not be
    // #expect(validator.validate(input: "email.@domain.com").isValid == false, "Trailing dot in address is not allowed")
    // #expect(validator.validate(input: "Joe Smith <email@domain.com>").isValid == false, "Encoded HTML within an email is invalid")
    // #expect(validator.validate(input: "email@domain@domain.com").isValid == false, "Two @ sign")
    // #expect(validator.validate(input: ".email@domain.com").isValid == false, "The leading dot in the address is not allowed")
    // #expect(validator.validate(input: "email..email@domain.com").isValid == false, "Multiple dots")
    // #expect(validator.validate(input: "あいうえお@domain.com").isValid == false, "Unicode char as address")
    // #expect(validator.validate(input: "email@domain.com (Joe Smith)").isValid == false, "Text followed email is not allowed")
    // #expect(validator.validate(input: "email@domain.web").isValid == false, ".web is not a valid top-level domain")
    // #expect(validator.validate(input: "email@111.222.333.44444").isValid == false, "Invalid IP format")

    // These cases are currently considered valid, but they should not be (test cases from ChatGPT)
    // #expect(validator.validate(input: "john@doe@example.com").isValid == false, "Email with multiple @ symbols")
    // #expect(validator.validate(input: "john doe@example.com").isValid == false, "Email with a space character")
    // #expect(validator.validate(input: "john..doe@example.com").isValid == false, "Email with consecutive dots in the local part")
  }
}
