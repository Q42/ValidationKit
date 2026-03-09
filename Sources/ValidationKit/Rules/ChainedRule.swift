import Foundation

/// Chains two rules: the output of the first feeds the input of the second. Short-circuits on failure.
public struct ChainedRule<First: ValidationRule, Second: ValidationRule>: ValidationRule
    where First.Output == Second.Input
{
    public typealias Input = First.Input
    public typealias Output = Second.Output

    /// The first rule in the chain.
    let first: First
    /// The second rule in the chain, receiving the output of the first.
    let second: Second

    /// Creates a chained rule from two rules.
    public init(first: First, second: Second) {
        self.first = first
        self.second = second
    }

    public func validate(_ input: First.Input) -> ValidationResult<Second.Output> {
        switch first.validate(input) {
        case let .valid(value):
            return second.validate(value)
        case let .invalid(errors):
            return .invalid(errors)
        }
    }
}

extension ChainedRule: Sendable where First: Sendable, Second: Sendable {}

/// Chains two rules so that both must pass. The output of the left feeds the input of the right.
public func && <First: ValidationRule, Second: ValidationRule>(
    lhs: First, rhs: Second
) -> ChainedRule<First, Second> where First.Output == Second.Input {
    ChainedRule(first: lhs, second: rhs)
}
