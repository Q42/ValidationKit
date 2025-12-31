import Testing
import ValidationKit

@Suite("Selection Validator Tests")
struct SelectionTests {
  @Test("Any of options validation")
  func testAnyOf() {
    let validator = Validator<String, String>.anyOf(options: [
      ("a", "Option A"),
      ("b", "Option B"),
      ("c", "Option C"),
    ])

    // Invalid
    #expect(validator.validate(input: "d").isValid == false, "Option not in list should be invalid")
    #expect(validator.validate(input: "").isValid == false, "Empty string should be invalid")

    // Valid
    #expect(validator.validate(input: "a").value == "Option A", "Valid option 'a' should return 'Option A'")
    #expect(validator.validate(input: "b").value == "Option B", "Valid option 'b' should return 'Option B'")
    #expect(validator.validate(input: "c").value == "Option C", "Valid option 'c' should return 'Option C'")

    // Error message
    #expect(ValidationError.invalidOption(option: "hello").localizedDescription == "invalid option hello", "Error message should specify the invalid option")
  }
}
