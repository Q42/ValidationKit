import XCTest
import ValidationKit

class EmptyTests: XCTestCase {
  func testIsEmpty() {
    let validator = Validator<String?, String>.isEmpty

    // Valid
    XCTAssertEqual(validator.validate(input: "").value, "")
    XCTAssertEqual(validator.validate(input: " ").value, "")

    // Invalid
    XCTAssertFalse(validator.validate(input: "eerste etage").isValid)
    XCTAssertFalse(validator.validate(input: "F").isValid)
  }

  func testNotEmpty() {
    let validator = Validator<String?, String>.notEmpty

    // Valid
    XCTAssertEqual(validator.validate(input: "eerste etage").value, "eerste etage")
    XCTAssertEqual(validator.validate(input: " F").value, "F")
    XCTAssertEqual(validator.validate(input: "F ").value, "F")

    // Invalid
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: " ").isValid)
  }
}
