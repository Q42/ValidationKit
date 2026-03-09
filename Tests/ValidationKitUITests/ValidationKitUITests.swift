@testable import ValidationKit
@testable import ValidationKitUI
import Testing

@MainActor
struct FieldValidationTests {
    @Test func validateImmediate() {
        let field = FieldValidation(EmailRule())

        #expect(field.result == nil)

        let result = field.validate("test@example.com")
        #expect(result.isValid)
        #expect(field.result?.isValid == true)
    }

    @Test func validateInvalid() {
        let field = FieldValidation(EmailRule())

        let result = field.validate("not-an-email")
        #expect(!result.isValid)
        #expect(field.result?.isValid != true)
    }

    @Test func clear() {
        let field = FieldValidation(EmailRule())
        field.validate("not-an-email")

        #expect(field.result != nil)
        field.clear()
        #expect(field.result == nil)
    }

    @Test func fieldValidationWithAllRule() {
        let field = FieldValidation(AllRule<String>.all(.notEmpty, .minLength(8), .email))

        let result = field.validate("ab")
        #expect(!result.isValid)
        #expect(result.errors.count == 2)
    }
}

@MainActor
struct FormValidationTests {
    @Test func validateAllSuccess() {
        let form = FormValidation()
        let emailField = FieldValidation(EmailRule())
        let nameField = FieldValidation(NotEmptyRule())

        form.register(emailField) { "test@example.com" }
        form.register(nameField) { "John" }

        #expect(!form.didAttemptSubmit)
        #expect(form.validateAll())
        #expect(form.didAttemptSubmit)
    }

    @Test func validateAllFailure() {
        let form = FormValidation()
        let emailField = FieldValidation(EmailRule())
        let nameField = FieldValidation(NotEmptyRule())

        form.register(emailField) { "not-an-email" }
        form.register(nameField) { "" }

        #expect(!form.validateAll())
        #expect(form.didAttemptSubmit)
    }

    @Test func reset() {
        let form = FormValidation()
        form.validateAll()

        #expect(form.didAttemptSubmit)
        form.reset()
        #expect(!form.didAttemptSubmit)
    }
}
