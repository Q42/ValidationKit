import Foundation

/// Validates that a string starts with a given prefix.
public struct HasPrefixRule: ValidationRule, Sendable {
    let prefix: String

    init(prefix: String) {
        self.prefix = prefix
    }

    public func validate(_ input: String) -> ValidationResult<String> {
        if input.hasPrefix(prefix) {
            return .valid(input)
        } else {
            return .invalid(ValidationError.invalidPrefix(prefix: prefix))
        }
    }
}

public extension ValidationRule where Self == HasPrefixRule {
    /// The value must start with the given prefix.
    static func hasPrefix(_ prefix: String) -> HasPrefixRule {
        HasPrefixRule(prefix: prefix)
    }
}
