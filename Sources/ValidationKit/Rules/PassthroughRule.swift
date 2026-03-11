import Foundation

/// A rule that always passes, returning the input unchanged.
public struct PassthroughRule<Value>: ValidationRule, Sendable {
    public func validate(_ input: Value) -> ValidationResult<Value> {
        .valid(input)
    }

    /// No validation; always passes.
    public static var none: PassthroughRule<Value> {
        PassthroughRule()
    }
}
