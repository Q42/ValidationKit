import SwiftUI
import ValidationKit

/// Observable per-field validation state.
///
/// Manages debounced validation while editing, immediate validation on blur/submit,
/// and clearing state on focus.
@Observable
@MainActor
public final class FieldValidation<Rule: ValidationRule> {
    /// The validation rule applied to this field.
    let rule: Rule
    /// The most recent validation result, or `nil` if the field has not been validated yet.
    public private(set) var result: ValidationResult<Rule.Output>?
    /// The errors from the most recent validation, or an empty array if valid or not yet validated.
    public var errors: [ValidationError] { result?.errors ?? [] }
    /// The delay before debounced validation fires. Defaults to 2 seconds.
    let debounceInterval: Duration = .seconds(2)

    private var debounceTask: Task<Void, Never>?

    /// Creates a field validation with the given rule.
    public init(_ rule: Rule) {
        self.rule = rule
    }

    /// Validate immediately. Returns the validation result.
    @discardableResult
    public func validate(_ input: Rule.Input) -> ValidationResult<Rule.Output> {
        debounceTask?.cancel()
        debounceTask = nil
        let validationResult = rule.validate(input)
        result = validationResult
        return validationResult
    }

    /// Schedule a debounced validation. Cancels any pending debounce.
    public func validateDebounced(_ input: Rule.Input) {
        debounceTask?.cancel()
        debounceTask = Task { [debounceInterval] in
            try? await Task.sleep(for: debounceInterval)
            guard !Task.isCancelled else { return }
            let validationResult = rule.validate(input)
            result = validationResult
        }
    }

    /// Clear validation state.
    public func clear() {
        debounceTask?.cancel()
        debounceTask = nil
        result = nil
    }
}
