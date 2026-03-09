import SwiftUI

/// A convenience wrapper that creates a `FormValidation` and injects it into the environment.
public struct ValidatedForm<Content: View>: View {
    @State private var form = FormValidation()
    let content: (FormValidation) -> Content

    public init(@ViewBuilder content: @escaping (FormValidation) -> Content) {
        self.content = content
    }

    public var body: some View {
        content(form)
            .environment(form)
    }
}
