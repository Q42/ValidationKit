import Foundation

/// Validates that a string is empty (after trimming whitespace).
public struct IsEmptyRule: ValidationRule, Sendable {
    public init() {}

    public func validate(_ input: String) -> ValidationResult<String> {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return .valid(trimmed)
        } else {
            return .invalid(ValidationError.isEmpty)
        }
    }
}

public extension ValidationRule where Self == IsEmptyRule {
    /// The value must be empty.
    static var isEmpty: IsEmptyRule {
        IsEmptyRule()
    }
}
