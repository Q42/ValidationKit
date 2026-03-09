import SwiftUI
@testable import ValidationKit

/// Protocol for type-erased field validation, allowing heterogeneous storage.
@MainActor
protocol AnyFieldValidation: AnyObject {
    func validateFromForm(_ value: Any) -> Bool
}

extension FieldValidation: AnyFieldValidation {
    func validateFromForm(_ value: Any) -> Bool {
        guard let input = value as? Rule.Input else { return false }
        return validate(input).isValid
    }
}

/// Coordinates validation across all fields in a form.
///
/// Register fields using the `.validated()` modifier. Call `validateAll()` on submit
/// to trigger validation on every registered field.
@Observable
@MainActor
public final class FormValidation {
    /// Whether `validateAll()` has been called at least once since the last reset.
    public private(set) var didAttemptSubmit = false

    struct FieldEntry {
        weak var field: AnyFieldValidation?
        let getCurrentValue: () -> Any
    }

    var fields: [FieldEntry] = []

    /// Creates an empty form validation coordinator.
    public init() {}

    func register<Rule: ValidationRule>(_ field: FieldValidation<Rule>, currentValue: @escaping () -> Rule.Input) {
        // Avoid duplicate registrations
        guard !fields.contains(where: { $0.field === field }) else { return }
        fields.append(FieldEntry(field: field, getCurrentValue: { currentValue() as Any }))
    }

    /// Validate all registered fields. Returns true if all fields are valid.
    @discardableResult
    public func validateAll() -> Bool {
        didAttemptSubmit = true
        // Clean up any deallocated fields
        fields.removeAll(where: { $0.field == nil })
        return fields.allSatisfy { entry in
            guard let field = entry.field else { return true }
            return field.validateFromForm(entry.getCurrentValue())
        }
    }

    /// Reset the form state and clear all field validations.
    public func reset() {
        didAttemptSubmit = false
        fields.removeAll(where: { $0.field == nil })
    }
}
