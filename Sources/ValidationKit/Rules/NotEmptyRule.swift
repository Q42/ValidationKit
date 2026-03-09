import Foundation

/// Validates that a string is not empty (after trimming whitespace).
public struct NotEmptyRule: ValidationRule, Sendable {
    public init() {}

    public func validate(_ input: String) -> ValidationResult<String> {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            return .valid(trimmed)
        } else {
            return .invalid(ValidationError.notEmpty)
        }
    }
}

public extension ValidationRule where Self == NotEmptyRule {
    /// The value must not be empty.
    static var notEmpty: NotEmptyRule {
        NotEmptyRule()
    }
}
