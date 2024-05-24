//
//  ValidationModifier.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 24/05/2024.
//

import SwiftUI

public struct EnvironmentValidator<Input, Output> {
    public let validator: Validator<Input, Output>
    @Binding public var result: ValidationResult<Output>?

    @discardableResult
    public func validate(input: Input) -> ValidationResult<Output> {
        let result = validator.validate(input: input)
        self.result = result
        return result
    }

    fileprivate init(validator: Validator<Input, Output>, result: Binding<ValidationResult<Output>?>) {
        self.validator = validator
        self._result = result
    }
}

private struct ValidatorModifierWithState: ViewModifier {
    let validator: Validator<String, String>
    @State var result: ValidationResult<String>?

    func body(content: Content) -> some View {
        content.environment(\.validator, EnvironmentValidator(validator: validator, result: $result))
    }
}

private struct ValidatorModifierWithBinding: ViewModifier {
    let validator: Validator<String, String>
    @Binding var result: ValidationResult<String>?

    func body(content: Content) -> some View {
        content.environment(\.validator, EnvironmentValidator(validator: validator, result: $result))
    }
}

public extension View {
    func validator(_ validator: Validator<String, String>) -> some View {
        modifier(ValidatorModifierWithState(validator: validator))
    }

    func validator(_ validator: Validator<String, String>, result: Binding<ValidationResult<String>?>) -> some View {
        modifier(ValidatorModifierWithBinding(validator: validator, result: result))
    }
}

public extension EnvironmentValues {
    var validator: EnvironmentValidator<String, String>? {
        get { return self[ValidatorEnvironmentKey.self] }
        set { self[ValidatorEnvironmentKey.self] = newValue }
    }
}

private struct ValidatorEnvironmentKey: EnvironmentKey {
    static let defaultValue: EnvironmentValidator<String, String>? = nil
}
