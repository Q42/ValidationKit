import Foundation

/// Validates that a string has exactly a given number of characters.
public struct ExactLengthRule: ValidationRule, Sendable {
    let length: Int

    public init(length: Int) {
        self.length = length
    }

    public func validate(_ input: String) -> ValidationResult<String> {
        if input.count == length {
            return .valid(input)
        } else {
            return .invalid(ValidationError.notExactLength(exactLength: length))
        }
    }
}

public extension ValidationRule where Self == ExactLengthRule {
    /// The value must be exactly the given length.
    static func exactLength(_ length: Int) -> ExactLengthRule {
        ExactLengthRule(length: length)
    }
}
