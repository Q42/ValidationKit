import Foundation

/// Validates that a string has at most a maximum number of characters.
public struct MaxLengthRule: ValidationRule, Sendable {
    let length: Int

    public init(length: Int) {
        self.length = length
    }

    public func validate(_ input: String) -> ValidationResult<String> {
        if input.count <= length {
            return .valid(input)
        } else {
            return .invalid(ValidationError.tooLong(maxLength: length))
        }
    }
}

public extension ValidationRule where Self == MaxLengthRule {
    /// The value must be at most the given length.
    static func maxLength(_ length: Int) -> MaxLengthRule {
        MaxLengthRule(length: length)
    }
}
