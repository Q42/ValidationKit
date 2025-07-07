import Testing
import ValidationKit

@Suite("Combination Tests")
struct CombinationTests {
  @Test("Operators combined validation")
  func testOperatorsCombined() {
    let validator: Validator<String?, String> = .isEmpty || .notEmpty && .maxLength(5)

    // Valid
    #expect(validator.validate(input: "").isValid == true, "Empty string should be valid with isEmpty validator")
    #expect(validator.validate(input: "abc").isValid == true, "Short string should be valid with notEmpty && maxLength")

    // Invalid
    #expect(validator.validate(input: "abcdef").isValid == false, "Long string should be invalid with maxLength constraint")
  }
}
