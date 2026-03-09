@testable import ValidationKit
@testable import ValidationKitUI
import XCTest

@MainActor
class FieldValidationTests: XCTestCase {
    func testValidateImmediate() {
        let field = FieldValidation(EmailRule())

        XCTAssertNil(field.result)

        let result = field.validate("test@example.com")
        XCTAssertTrue(result.isValid)
        XCTAssertTrue(field.result?.isValid == true)
    }

    func testValidateInvalid() {
        let field = FieldValidation(EmailRule())

        let result = field.validate("not-an-email")
        XCTAssertFalse(result.isValid)
        XCTAssertFalse(field.result?.isValid == true)
    }

    func testClear() {
        let field = FieldValidation(EmailRule())
        field.validate("not-an-email")

        XCTAssertNotNil(field.result)
        field.clear()
        XCTAssertNil(field.result)
    }

    func testFieldValidationWithAllRule() {
        let field = FieldValidation(AllRule<String>.all(.notEmpty, .minLength(8), .email))

        let result = field.validate("ab")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errors.count, 2)
    }
}

@MainActor
class FormValidationTests: XCTestCase {
    func testValidateAllSuccess() {
        let form = FormValidation()
        let emailField = FieldValidation(EmailRule())
        let nameField = FieldValidation(NotEmptyRule())

        form.register(emailField) { "test@example.com" }
        form.register(nameField) { "John" }

        XCTAssertFalse(form.didAttemptSubmit)
        XCTAssertTrue(form.validateAll())
        XCTAssertTrue(form.didAttemptSubmit)
    }

    func testValidateAllFailure() {
        let form = FormValidation()
        let emailField = FieldValidation(EmailRule())
        let nameField = FieldValidation(NotEmptyRule())

        form.register(emailField) { "not-an-email" }
        form.register(nameField) { "" }

        XCTAssertFalse(form.validateAll())
        XCTAssertTrue(form.didAttemptSubmit)
    }

    func testReset() {
        let form = FormValidation()
        form.validateAll()

        XCTAssertTrue(form.didAttemptSubmit)
        form.reset()
        XCTAssertFalse(form.didAttemptSubmit)
    }
}
