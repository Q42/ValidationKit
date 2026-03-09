import Foundation

/// Tries the first rule, and falls back to the second if it fails. Merges errors if both fail.
public struct EitherRule<First: ValidationRule, Second: ValidationRule>: ValidationRule
    where First.Input == Second.Input, First.Output == Second.Output
{
    public typealias Input = First.Input
    public typealias Output = First.Output

    /// The preferred rule, tried first.
    let first: First
    /// The fallback rule, tried when the first fails.
    let second: Second

    /// Creates an either rule from two rules.
    public init(first: First, second: Second) {
        self.first = first
        self.second = second
    }

    public func validate(_ input: First.Input) -> ValidationResult<First.Output> {
        let firstResult = first.validate(input)
        switch firstResult {
        case .valid:
            return firstResult
        case .invalid:
            return second.validate(input)
        }
    }
}

extension EitherRule: Sendable where First: Sendable, Second: Sendable {}

/// Combines two rules so that either can pass. Falls back to the second if the first fails.
public func || <First: ValidationRule, Second: ValidationRule>(
    lhs: First, rhs: Second
) -> EitherRule<First, Second> where First.Input == Second.Input, First.Output == Second.Output {
    EitherRule(first: lhs, second: rhs)
}
