@testable import ValidationKit
@testable import ValidationKitUI
import Testing

@MainActor
struct GroupValidationTests {
    @Test func validateAllSuccess() {
        let group = GroupValidation()
        let emailField = FieldValidation(EmailRule())
        let nameField = FieldValidation(NotEmptyRule())

        group.references = [
            ValidatedFieldReference(id: ObjectIdentifier(emailField), validate: { emailField.validate("test@example.com").isValid }),
            ValidatedFieldReference(id: ObjectIdentifier(nameField), validate: { nameField.validate("John").isValid }),
        ]

        #expect(!group.didAttemptSubmit)
        #expect(group.validateAll())
        #expect(group.didAttemptSubmit)
    }

    @Test func validateAllFailure() {
        let group = GroupValidation()
        let emailField = FieldValidation(EmailRule())
        let nameField = FieldValidation(NotEmptyRule())

        group.references = [
            ValidatedFieldReference(id: ObjectIdentifier(emailField), validate: { emailField.validate("not-an-email").isValid }),
            ValidatedFieldReference(id: ObjectIdentifier(nameField), validate: { nameField.validate("").isValid }),
        ]

        #expect(!group.validateAll())
        #expect(group.didAttemptSubmit)
    }

    @Test func reset() {
        let group = GroupValidation()
        group.validateAll()

        #expect(group.didAttemptSubmit)
        group.reset()
        #expect(!group.didAttemptSubmit)
    }
}
