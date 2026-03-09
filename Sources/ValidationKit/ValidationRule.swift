import Foundation

/// A type that validates input and produces either a validated output or validation errors.
public protocol ValidationRule<Input, Output> {
    /// The type of value this rule accepts for validation.
    associatedtype Input
    /// The type of value this rule produces on successful validation.
    associatedtype Output
    /// Validates the given input and returns a result indicating success or failure.
    func validate(_ input: Input) -> ValidationResult<Output>
}
