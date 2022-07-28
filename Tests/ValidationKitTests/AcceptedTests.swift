import XCTest
import ValidationKit

class AcceptedTests: XCTestCase {
  func testAccepted() {
    let validator = Validator<Bool, Bool>.accepted

    XCTAssertFalse(validator.validate(input: false).isValid)
    XCTAssertTrue(validator.validate(input: true).isValid)

    XCTAssertEqual(validator.validate(input: true).value, true)
  }
}
