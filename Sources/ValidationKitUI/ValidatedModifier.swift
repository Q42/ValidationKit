import SwiftUI
@testable import ValidationKit

struct ValidatedModifier<Rule: ValidationRule>: ViewModifier where Rule.Input == String {
    let field: FieldValidation<Rule>
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @Environment(FormValidation.self) private var form: FormValidation?

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .onChange(of: isFocused) { _, focused in
                if focused {
                    field.clear()
                } else {
                    field.validate(text)
                }
            }
            .onChange(of: text) {
                if isFocused {
                    field.validateDebounced(text)
                }
            }
            .onAppear {
                form?.register(field) { text }
            }
    }
}

public extension View {
    /// Attaches validation behavior to a text field.
    ///
    /// Handles debounced validation while editing, immediate validation on blur,
    /// and registration with a parent `FormValidation` if present in the environment.
    func validated<Rule: ValidationRule>(
        _ field: FieldValidation<Rule>,
        text: Binding<String>
    ) -> some View where Rule.Input == String {
        modifier(ValidatedModifier(field: field, text: text))
    }
}
