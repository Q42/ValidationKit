import Foundation

/// Validates that a boolean value is true.
public struct AcceptedRule: ValidationRule, Sendable {
    public init() {}

    public func validate(_ input: Bool) -> ValidationResult<Bool> {
        if input {
            return .valid(input)
        } else {
            return .invalid(ValidationError.notAccepted)
        }
    }
}

public extension ValidationRule where Self == AcceptedRule {
    /// The value must be accepted (true).
    static var accepted: AcceptedRule {
        AcceptedRule()
    }
}
