import Foundation

/// The result of validating input against a ``ValidationRule``.
///
/// A result is either ``valid(_:)`` with the validated output value,
/// or ``invalid(_:)-swift.enum.case`` with one or more ``ValidationError``s.
public enum ValidationResult<Value> {
    /// Validation succeeded, producing the given value.
    case valid(Value)
    /// Validation failed with the given errors.
    case invalid([ValidationError])
}

public extension ValidationResult {
    /// Convenience for creating an invalid result with a single error.
    static func invalid(_ error: ValidationError) -> Self {
        .invalid([error])
    }

    /// All validation errors, or an empty array if valid.
    var errors: [ValidationError] {
        if case let .invalid(errors) = self {
            return errors
        } else {
            return []
        }
    }

    /// Whether the validation passed.
    var isValid: Bool {
        if case .valid = self {
            return true
        } else {
            return false
        }
    }

    /// The validated value, or nil if invalid.
    var value: Value? {
        if case let .valid(value) = self {
            return value
        } else {
            return nil
        }
    }
}
