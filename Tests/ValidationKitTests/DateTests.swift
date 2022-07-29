import XCTest
import ValidationKit

class DateTests: XCTestCase {
  func testIsDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"

    let validator = Validator<String, Date>.isDate(formatter: dateFormatter)

    // Valid
    XCTAssertTrue(validator.validate(input: "2021-03-28 12:11:25").isValid)

    // Invalid
    XCTAssertFalse(validator.validate(input: "2021-03-28").isValid)
    XCTAssertFalse(validator.validate(input: "12:11:25").isValid)
    XCTAssertFalse(validator.validate(input: "test").isValid)
  }
}
