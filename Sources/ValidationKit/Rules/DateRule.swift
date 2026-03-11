import Foundation

/// Validates that a string can be parsed as a date using the given formatter.
public struct DateRule: ValidationRule {
    let formatter: DateFormatter

    init(formatter: DateFormatter) {
        self.formatter = formatter
    }

    public func validate(_ input: String) -> ValidationResult<Date> {
        if let date = formatter.date(from: input) {
            return .valid(date)
        } else {
            return .invalid(ValidationError.invalidDate)
        }
    }
}

public extension ValidationRule where Self == DateRule {
    /// The value must be parseable as a date using the given formatter.
    static func isDate(formatter: DateFormatter) -> DateRule {
        DateRule(formatter: formatter)
    }
}
