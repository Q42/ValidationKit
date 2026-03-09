import Foundation

/// Validates that a string matches one of the given options, mapping to the associated result.
public struct AnyOfRule<Result>: ValidationRule {
    let options: [(String, Result)]

    public init(options: [(String, Result)]) {
        self.options = options
    }

    public func validate(_ input: String) -> ValidationResult<Result> {
        if let option = options.first(where: { $0.0 == input }) {
            return .valid(option.1)
        } else {
            return .invalid(ValidationError.invalidOption(option: input))
        }
    }
}

public extension ValidationRule {
    /// The value must be one of the given options.
    static func anyOf<Result>(options: [(String, Result)]) -> AnyOfRule<Result>
        where Self == AnyOfRule<Result>
    {
        AnyOfRule(options: options)
    }
}
