import XCTest
import ValidationKit

class StringTests: XCTestCase {
  func testHasPrefix() {
    let validator = Validator<String, String>.hasPrefix("42")

    // Invalid
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "hello").isValid)

    // Valid
    XCTAssertEqual(validator.validate(input: "4200").value, "4200")
    XCTAssertEqual(validator.validate(input: "42").value, "42")

    // Error message
    XCTAssertEqual(ValidationError.invalidPrefix(prefix: "hoi").localizedDescription, "must start with hoi")
  }
}
