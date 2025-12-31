import Testing
import Foundation
import ValidationKit

@Suite("Date Validator Tests")
struct DateTests {
  @Test("Date validation with custom formatter")
  func isDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"

    let validator = Validator<String, Date>.isDate(formatter: dateFormatter)

    // Valid date format
    #expect(validator.validate(input: "2021-03-28 12:11:25").isValid, "Valid date string should pass validation")

    // Invalid date formats
    #expect(validator.validate(input: "2021-03-28").isValid == false, "Date without time should be invalid")
    #expect(validator.validate(input: "12:11:25").isValid == false, "Time without date should be invalid")
    #expect(validator.validate(input: "test").isValid == false, "Non-date string should be invalid")
  }
}
