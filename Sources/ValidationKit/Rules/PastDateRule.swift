import Foundation

/// Validates that a date is in the past.
public struct PastDateRule: ValidationRule, Sendable {
    public init() {}

    public func validate(_ input: Date) -> ValidationResult<Date> {
        if input < Date() {
            return .valid(input)
        } else {
            return .invalid(ValidationError.dateInTheFuture)
        }
    }
}

public extension ValidationRule where Self == PastDateRule {
    /// The date must be in the past.
    static var isInThePast: PastDateRule {
        PastDateRule()
    }
}
