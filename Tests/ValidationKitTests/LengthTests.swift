import XCTest
import ValidationKit

class LengthTests: XCTestCase {
  func testMinLength() {
    let validator = Validator<String, String>.minLength(5)

    // Invalid
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "hoi").isValid)
    XCTAssertNil(validator.validate(input: "").value)

    // Valid
    XCTAssertTrue(validator.validate(input: "hello").isValid)
    XCTAssertTrue(validator.validate(input: "this is a test").isValid)

    // Error message
    XCTAssertEqual(ValidationError.tooShort(minLength: 5).localizedDescription, "must be 5 or more characters long")
  }

  func testMaxLength() {
    let validator = Validator<String, String>.maxLength(5)

    // Invalid
    XCTAssertFalse(validator.validate(input: "hello world").isValid)
    XCTAssertFalse(validator.validate(input: "this is a test").isValid)

    // Valid
    XCTAssertTrue(validator.validate(input: "hello").isValid)
    XCTAssertTrue(validator.validate(input: "123").isValid)

    // Error message
    XCTAssertEqual(ValidationError.tooLong(maxLength: 5).localizedDescription, "must be 5 or fewer characters long")
  }

  func testExactLength() {
    let validator = Validator<String, String>.exactLength(10)

    // Invalid
    XCTAssertFalse(validator.validate(input: "").isValid)
    XCTAssertFalse(validator.validate(input: "hello").isValid)
    XCTAssertFalse(validator.validate(input: "this is only a test").isValid)

    // Valid
    XCTAssertTrue(validator.validate(input: "helloworld").isValid)

    // Error message
    XCTAssertEqual(ValidationError.notExactLength(exactLength: 5).localizedDescription, "must be exactly 5 characters long")
  }
}
