import SwiftUI
import ValidationKit

struct ValidatedFieldReference: Equatable {
    let id: ObjectIdentifier
    let validate: () -> Bool
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
}

struct ValidatedFieldPreferenceKey: PreferenceKey {
    static let defaultValue: [ValidatedFieldReference] = []
    static func reduce(value: inout [ValidatedFieldReference], nextValue: () -> [ValidatedFieldReference]) {
        value.append(contentsOf: nextValue())
    }
}

/// Coordinates validation across all fields in a group.
///
/// Attach fields using `.validatedField()` and collect them with `.validationGroup(group)`.
/// Call `validateAll()` on submit to trigger validation on every registered field.
@Observable
@MainActor
public final class GroupValidation {
    /// Whether `validateAll()` has been called at least once since the last reset.
    var didAttemptSubmit = false

    var references: [ValidatedFieldReference] = []

    /// Creates an empty form validation coordinator.
    public init() {}

    /// Validate all registered fields. Returns true if all fields are valid.
    @discardableResult
    public func validateAll() -> Bool {
        didAttemptSubmit = true
        return references.map { $0.validate() }.allSatisfy { $0 }
    }

    /// Reset the form state.
    public func reset() {
        didAttemptSubmit = false
    }
}
