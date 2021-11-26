@testable import ValidationKit
import XCTest

class ValidatedPropertyWrapperTests: XCTestCase {
  struct Person {
    @Validated(.notEmpty)
    var name: String? = nil

    @Validated(.notEmpty && .exactLength(6))
    var postalCode: String? = nil
  }

  func testValidatable() {
    let validPerson = Person(name: "Mathijs", postalCode: "8049BW")
    XCTAssertTrue(validPerson.$name.isValid)
    XCTAssertEqual(validPerson.$name.value, "Mathijs")
    XCTAssertTrue(validPerson.$postalCode.isValid)
    XCTAssertEqual(validPerson.$postalCode.value, "8049BW")

    let invalidPerson = Person(name: "", postalCode: "1234")
    XCTAssertFalse(invalidPerson.$name.isValid)
    XCTAssertNil(invalidPerson.$name.value)
    XCTAssertFalse(invalidPerson.$postalCode.isValid)
    XCTAssertNil(invalidPerson.$postalCode.value)
  }
}
