import Foundation

/// Validates that a string has at least a minimum number of characters.
public struct MinLengthRule: ValidationRule, Sendable {
    let length: Int

    public init(length: Int) {
        self.length = length
    }

    public func validate(_ input: String) -> ValidationResult<String> {
        if input.count >= length {
            return .valid(input)
        } else {
            return .invalid(ValidationError.tooShort(minLength: length))
        }
    }
}

public extension ValidationRule where Self == MinLengthRule {
    /// The value must be at least the given length.
    static func minLength(_ length: Int) -> MinLengthRule {
        MinLengthRule(length: length)
    }
}
