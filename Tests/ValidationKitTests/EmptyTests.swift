import Testing
import ValidationKit

@Suite("Empty Validator Tests")
struct EmptyTests {

  @Test("isEmpty validator with nullable strings")
  func isEmptyNullable() {
    let validator = Validator<String?, String>.isEmpty

    // Valid cases
    #expect(validator.validate(input: nil).value == "", "Nil input should be converted to empty string")
    #expect(validator.validate(input: "").value == "", "Empty string should remain empty string")
    #expect(validator.validate(input: " ").value == "", "Whitespace-only string should be converted to empty string")

    // Invalid cases
    #expect(validator.validate(input: "eerste etage").isValid == false, "Non-empty string should be invalid")
    #expect(validator.validate(input: "F").isValid == false, "Single character should be invalid")
  }

  @Test("notEmpty validator with nullable strings")
  func notEmptyNullable() {
    let validator = Validator<String?, String>.notEmpty

    // Valid cases
    #expect(validator.validate(input: "eerste etage").value == "eerste etage", "Non-empty string should return trimmed value")
    #expect(validator.validate(input: " F").value == "F", "Leading whitespace should be trimmed")
    #expect(validator.validate(input: "F ").value == "F", "Trailing whitespace should be trimmed")

    // Invalid cases
    #expect(validator.validate(input: nil).isValid == false, "Nil input should be invalid")
    #expect(validator.validate(input: "").isValid == false, "Empty string should be invalid")
    #expect(validator.validate(input: " ").isValid == false, "Whitespace-only string should be invalid")
  }

  @Test("isEmpty validator with non-nullable strings")
  func isEmpty() {
    let validator = Validator<String, String>.isEmpty

    // Valid cases
    #expect(validator.validate(input: "").value == "", "Empty string should return empty string")
    #expect(validator.validate(input: " ").value == "", "Whitespace-only string should be converted to empty string")

    // Invalid cases
    #expect(validator.validate(input: "eerste etage").isValid == false, "Non-empty string should be invalid")
    #expect(validator.validate(input: "F").isValid == false, "Single character should be invalid")
  }

  @Test("notEmpty validator with non-nullable strings")
  func notEmpty() {
    let validator = Validator<String, String>.notEmpty

    // Valid cases
    #expect(validator.validate(input: "eerste etage").value == "eerste etage", "Non-empty string should return trimmed value")
    #expect(validator.validate(input: " F").value == "F", "Leading whitespace should be trimmed")
    #expect(validator.validate(input: "F ").value == "F", "Trailing whitespace should be trimmed")

    // Invalid cases
    #expect(validator.validate(input: "").isValid == false, "Empty string should be invalid")
    #expect(validator.validate(input: " ").isValid == false, "Whitespace-only string should be invalid")
  }
}
