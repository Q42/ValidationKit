@testable import ValidationKit
import XCTest

class ValidatedTests: XCTestCase {
  struct Person {
    @Validated(.notEmpty)
    var name: String? = nil

    @Validated(.notEmpty && .exactLength(6))
    var postalCode: String? = nil
  }

  func testValidatable() {
    let validPerson = Person(name: "Mathijs", postalCode: "8049BW")
    XCTAssertTrue(validPerson.$name.isValid)
    XCTAssertTrue(validPerson.$postalCode.isValid)

    let invalidPerson = Person(name: "", postalCode: "1234")
    XCTAssertFalse(invalidPerson.$name.isValid)
    XCTAssertFalse(invalidPerson.$postalCode.isValid)
  }
}
