import XCTest
import ValidationKit

class SelectionTests: XCTestCase {
  func testAnyOf() {
    let validator = Validator<String, String>.anyOf(options: [
      ("a", "Option A"),
      ("b", "Option B"),
      ("c", "Option C"),
    ])

    // Invalid
    XCTAssertFalse(validator.validate(input: "d").isValid)
    XCTAssertFalse(validator.validate(input: "").isValid)

    // Valid
    XCTAssertEqual(validator.validate(input: "a").value, "Option A")
    XCTAssertEqual(validator.validate(input: "b").value, "Option B")
    XCTAssertEqual(validator.validate(input: "c").value, "Option C")

    // Error message
    XCTAssertEqual(ValidationError.invalidOption(option: "hello").localizedDescription, "invalid option hello")
  }
}
