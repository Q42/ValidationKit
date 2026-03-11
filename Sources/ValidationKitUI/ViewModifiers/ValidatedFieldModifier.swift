import SwiftUI
import ValidationKit

struct ValidatedFieldModifier<Rule: ValidationRule>: ViewModifier where Rule.Input == String {
    var field: FieldValidation<Rule>
    @Binding var text: String
    @FocusState private var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .onChange(of: isFocused) { isFocused in
                if isFocused {
                    field.clear()
                } else {
                    field.validate(text)
                }
            }
            .onChange(of: text) { text in
                if isFocused {
                    field.validateDebounced(text)
                }
            }
            .preference(key: ValidatedFieldPreferenceKey.self, value: [
                ValidatedFieldReference(
                    id: ObjectIdentifier(field),
                    validate: { field.validate(text).isValid }
                )
            ])
    }
}

public extension View {
    /// Attaches validation behavior to a text field.
    ///
    /// Handles debounced validation while editing, immediate validation on blur,
    /// and reports the field to a parent `.validationGroup()`, if any.
    func validatedField<Rule: ValidationRule>(
        _ field: FieldValidation<Rule>,
        text: Binding<Rule.Input>
    ) -> some View where Rule.Input == String {
        modifier(ValidatedFieldModifier(field: field, text: text))
    }
}
