import Foundation

/// An error that occurs when input validation does not pass.
public struct ValidationError: Error, LocalizedError, Equatable, Hashable {
    /// A human-readable description of the validation error.
    public let localizedDescription: String

    public var errorDescription: String? {
        localizedDescription
    }

    /// Creates a validation error with the given localized description.
    public init(localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}

extension ValidationError: Identifiable {
    public var id: Self { self }
}

// MARK: - Built-in error constants

extension ValidationError {
    static let isEmpty = ValidationError(localizedDescription: "must be empty")
    static let notEmpty = ValidationError(localizedDescription: "may not be empty")
    static let invalidEmail = ValidationError(localizedDescription: "invalid e-mail address")
    static let invalidDate = ValidationError(localizedDescription: "is not a valid date")
    static let dateInTheFuture = ValidationError(localizedDescription: "date must be in the future")
    static let notAccepted = ValidationError(localizedDescription: "is not accepted")

    static func tooShort(minLength: Int) -> Self {
        ValidationError(localizedDescription: "must be \(minLength) or more characters long")
    }

    static func tooLong(maxLength: Int) -> Self {
        ValidationError(localizedDescription: "must be \(maxLength) or fewer characters long")
    }

    static func notExactLength(exactLength: Int) -> Self {
        ValidationError(localizedDescription: "must be exactly \(exactLength) characters long")
    }

    static func invalidPrefix(prefix: String) -> Self {
        ValidationError(localizedDescription: "must start with \(prefix)")
    }

    static func invalidOption(option: String) -> Self {
        ValidationError(localizedDescription: "invalid option \(option)")
    }
}
