import Testing
import ValidationKit

@Suite("String Validator Tests")
struct StringTests {
  @Test("Prefix validation")
  func testHasPrefix() {
    let validator = Validator<String, String>.hasPrefix("42")

    // Invalid
    #expect(validator.validate(input: "").isValid == false, "Empty string should be invalid")
    #expect(validator.validate(input: "hello").isValid == false, "String without prefix should be invalid")

    // Valid
    #expect(validator.validate(input: "4200").value == "4200", "String with prefix should return the original value")
    #expect(validator.validate(input: "42").value == "42", "String exactly matching prefix should return the original value")

    // Error message
    #expect(ValidationError.invalidPrefix(prefix: "hoi").localizedDescription == "must start with hoi", "Error message should contain the required prefix")
  }
}
