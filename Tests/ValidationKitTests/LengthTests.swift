import Testing
import ValidationKit

@Suite("Length Validator Tests")
struct LengthTests {
  @Test("Minimum length validation")
  func testMinLength() {
    let validator = Validator<String, String>.minLength(5)

    // Invalid
    #expect(validator.validate(input: "").isValid == false, "Empty string should be invalid")
    #expect(validator.validate(input: "hoi").isValid == false, "String shorter than minimum should be invalid")
    #expect(validator.validate(input: "").value == nil, "Invalid string should have no value")

    // Valid
    #expect(validator.validate(input: "hello").isValid == true, "String equal to minimum length should be valid")
    #expect(validator.validate(input: "this is a test").isValid == true, "String longer than minimum should be valid")

    // Error message
    #expect(ValidationError.tooShort(minLength: 5).localizedDescription == "must be 5 or more characters long", "Error message should specify minimum length")
  }

  @Test("Maximum length validation")
  func testMaxLength() {
    let validator = Validator<String, String>.maxLength(5)

    // Invalid
    #expect(validator.validate(input: "hello world").isValid == false, "String longer than maximum should be invalid")
    #expect(validator.validate(input: "this is a test").isValid == false, "String much longer than maximum should be invalid")

    // Valid
    #expect(validator.validate(input: "hello").isValid == true, "String equal to maximum length should be valid")
    #expect(validator.validate(input: "123").isValid == true, "String shorter than maximum should be valid")

    // Error message
    #expect(ValidationError.tooLong(maxLength: 5).localizedDescription == "must be 5 or fewer characters long", "Error message should specify maximum length")
  }

  @Test("Exact length validation")
  func testExactLength() {
    let validator = Validator<String, String>.exactLength(10)

    // Invalid
    #expect(validator.validate(input: "").isValid == false, "Empty string should be invalid")
    #expect(validator.validate(input: "hello").isValid == false, "String shorter than exact length should be invalid")
    #expect(validator.validate(input: "this is only a test").isValid == false, "String longer than exact length should be invalid")

    // Valid
    #expect(validator.validate(input: "helloworld").isValid == true, "String equal to exact length should be valid")

    // Error message
    #expect(ValidationError.notExactLength(exactLength: 5).localizedDescription == "must be exactly 5 characters long", "Error message should specify exact length requirement")
  }
}
