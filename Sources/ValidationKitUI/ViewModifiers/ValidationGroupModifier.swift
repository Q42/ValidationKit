import SwiftUI
import ValidationKit

struct GroupValidationModifier: ViewModifier {
    var group: GroupValidation

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ValidatedFieldPreferenceKey.self) { refs in
                group.references = refs
            }
    }
}

public extension View {
    /// Collects all `.validatedField()` entries from child views into the given form group.
    func validationGroup(_ group: GroupValidation) -> some View {
        modifier(GroupValidationModifier(group: group))
    }
}
