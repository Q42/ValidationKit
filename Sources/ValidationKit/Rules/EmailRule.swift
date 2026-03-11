import Foundation

private let emailPattern = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
    "\\@" +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    ")+"

/// Validates that a string is a valid email address according to the WHATWG HTML living standard.
public struct EmailRule: ValidationRule, Sendable {
    public func validate(_ input: String) -> ValidationResult<String> {
        if let range = input.range(of: emailPattern, options: .regularExpression) {
            let output = String(input[range])
            return .valid(output)
        } else {
            return .invalid(ValidationError.invalidEmail)
        }
    }
}

public extension ValidationRule where Self == EmailRule {
    /// The value must be a valid email address.
    static var email: EmailRule {
        EmailRule()
    }
}
