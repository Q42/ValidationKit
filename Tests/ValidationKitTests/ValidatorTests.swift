@testable import ValidationKit
import XCTest

final class ValidatorTests: XCTestCase {
  func testOperatorOr() {
    let validator: Validator<String?, String> = .isEmpty || .notEmpty && .maxLength(5)

    // true
    XCTAssertTrue(validator.validate(input: "").isValid)
    XCTAssertTrue(validator.validate(input: "abc").isValid)

    // false
    XCTAssertFalse(validator.validate(input: "abcdef").isValid)
  }

  func testIsEmpty() {
    let validator = Validator<String?, String>.isEmpty
    XCTAssertEqual(validator.validate(input: "").value, "")
    XCTAssertEqual(validator.validate(input: " ").value, "")
    XCTAssertFalse(validator.validate(input: "eerste etage").isValid)
    XCTAssertFalse(validator.validate(input: "F").isValid)
  }

  func testNotEmpty() {
    let validator = Validator<String?, String>.notEmpty
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: " ").isValid)
    XCTAssertEqual(validator.validate(input: "eerste etage").value, "eerste etage")
    XCTAssertEqual(validator.validate(input: " F").value, "F")
    XCTAssertEqual(validator.validate(input: "F ").value, "F")
  }

  func testMinLength() {
    let validator = Validator<String, String>.minLength(5)
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "hoi").isValid)
    XCTAssertNil(validator.validate(input: "").value)
    XCTAssertEqual(validator.validate(input: "hello").value, "hello")
    XCTAssertEqual(validator.validate(input: "this is a test").value, "this is a test")
  }

  func testMaxLength() {
    let validator = Validator<String, String>.maxLength(5)
    XCTAssertFalse(validator.validate(input: "hello world").isValid)
    XCTAssertFalse(validator.validate(input: "this is a test").isValid)
    XCTAssertEqual(validator.validate(input: "hello").value, "hello")
    XCTAssertEqual(validator.validate(input: "123").value, "123")
  }

  func testExactLength() {
    let validator = Validator<String, String>.exactLength(10)
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "hello").isValid)
    XCTAssertFalse(validator.validate(input: "this is only a test").isValid)
    XCTAssertEqual(validator.validate(input: "helloworld").value, "helloworld")
  }

  func testIsDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
    let validator = Validator<String, Date>.isDate(formatter: dateFormatter)
    XCTAssertNotNil(validator.validate(input: "2021-03-28 12:11:25").value)
    XCTAssertFalse(validator.validate(input: "2021-03-28").isValid)
    XCTAssertFalse(validator.validate(input: "12:11:25").isValid)
    XCTAssertFalse(validator.validate(input: "test").isValid)
  }

  func testAnyOf() {
    let validator = Validator<String, String>.anyOf(options: [
      ("a", "Option A"),
      ("b", "Option B"),
      ("c", "Option C"),
    ])
    XCTAssertFalse(validator.validate(input: "d").isValid)
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertEqual(validator.validate(input: "a").value, "Option A")
    XCTAssertEqual(validator.validate(input: "b").value, "Option B")
    XCTAssertEqual(validator.validate(input: "c").value, "Option C")
  }

  func testAccepted() {
    let validator = Validator<Bool, Bool>.accepted
    XCTAssertFalse(validator.validate(input: false).isValid)
    XCTAssertTrue(validator.validate(input: true).isValid)
    XCTAssertEqual(validator.validate(input: true).value, true)
  }

  func testHasPrefix() {
    let validator = Validator<String, String>.hasPrefix("42")
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "hello").isValid)
    XCTAssertEqual(validator.validate(input: "4200").value, "4200")
    XCTAssertEqual(validator.validate(input: "42").value, "42")
  }

  func testErrorMessages() {
    XCTAssertEqual(ValidationError.tooShort(minLength: 5).localizedDescription, "must be 5 or more characters long")
    XCTAssertEqual(ValidationError.tooLong(maxLength: 5).localizedDescription, "must be 5 or fewer characters long")
    XCTAssertEqual(ValidationError.notExactLength(exactLength: 5).localizedDescription, "must be exactly 5 characters long")
    XCTAssertEqual(ValidationError.invalidPrefix(prefix: "hoi").localizedDescription, "must start with hoi")
    XCTAssertEqual(ValidationError.invalidOption(option: "hello").localizedDescription, "invalid option hello")
  }
}
