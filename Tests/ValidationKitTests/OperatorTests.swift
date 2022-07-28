import XCTest
import ValidationKit

class CombinationTests: XCTestCase {
  func testOperatorsCombined() {
    let validator: Validator<String?, String> = .isEmpty || .notEmpty && .maxLength(5)

    // Valid
    XCTAssertTrue(validator.validate(input: "").isValid)
    XCTAssertTrue(validator.validate(input: "abc").isValid)

    // Invalid
    XCTAssertFalse(validator.validate(input: "abcdef").isValid)
  }
}
