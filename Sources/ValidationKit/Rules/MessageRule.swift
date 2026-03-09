import Foundation

/// Wraps a rule and replaces its error messages with a custom message.
public struct MessageRule<Wrapped: ValidationRule>: ValidationRule {
    /// The underlying rule whose errors will be replaced.
    let wrapped: Wrapped
    /// The custom message to use when validation fails.
    let message: String

    /// Creates a message rule that wraps the given rule with a custom error message.
    public init(wrapped: Wrapped, message: String) {
        self.wrapped = wrapped
        self.message = message
    }

    public func validate(_ input: Wrapped.Input) -> ValidationResult<Wrapped.Output> {
        switch wrapped.validate(input) {
        case let .valid(value):
            return .valid(value)
        case .invalid:
            return .invalid(ValidationError(localizedDescription: message))
        }
    }
}

extension MessageRule: Sendable where Wrapped: Sendable {}

public extension ValidationRule {
    /// Replaces all error messages from this rule with the given message.
    func message(_ message: String) -> MessageRule<Self> {
        MessageRule(wrapped: self, message: message)
    }
}
