import Foundation

/// Runs all rules and collects all errors. Valid only if every rule passes.
public struct AllRule<Value>: ValidationRule {
    /// The rules to run against the input.
    let rules: [any ValidationRule<Value, Value>]

    /// Creates a rule that runs all the given rules and collects their errors.
    public init(rules: [any ValidationRule<Value, Value>]) {
        self.rules = rules
    }

    public func validate(_ input: Value) -> ValidationResult<Value> {
        let allErrors = rules.flatMap { $0.validate(input).errors }
        return allErrors.isEmpty ? .valid(input) : .invalid(allErrors)
    }

    /// Runs all given rules and collects all errors.
    public static func all(_ rules: any ValidationRule<Value, Value>...) -> AllRule<Value> {
        AllRule(rules: rules)
    }
}
