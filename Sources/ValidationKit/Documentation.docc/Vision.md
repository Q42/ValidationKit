# ValidationKit v2 — Vision & Goals

## What is ValidationKit?

ValidationKit is a lightweight Swift library for validating user input in forms. Names, email addresses, phone numbers, dates — any field that needs validation before submission.
It is designed to feel at home on Apple platforms.

## Why v2?

ValidationKit v1 served us well, but real-world usage surfaced four pain points that could not be fixed without breaking changes:

### 1. Single error limitation

In v1, `ValidationResult` held at most one `ValidationError`. Composed validators short-circuited at the first failure, so users could never see all problems at once. A sign-up form that required a non-empty, 8+ character email address would only ever show one error at a time.

**v2 solution:** `ValidationResult` now carries an array of errors:

```swift
case valid(Value)
case invalid([ValidationError])
```

The new `AllRule` runs every rule independently and collects all errors:

```swift
let rule: AllRule<String> = .all(.notEmpty, .minLength(8), .email)
let result = rule.validate("ab")
result.errors // [tooShort(minLength: 8), invalidEmail]
```

The `&&` operator still short-circuits (useful for type-transforming chains), while `AllRule` gives full error collection when you need it.

### 2. No SwiftUI integration

v1 provided no helpers for common form patterns: debounced validation while typing, validate-on-blur, or validate-all-on-submit. Consumers had to build this themselves every time.

**v2 solution:** A dedicated `ValidationKitUI` target (opt-in, depends only on `ValidationKit`) provides:

- **`FieldValidation`** — `@Observable` per-field state that handles debounce, immediate validation, and clearing.
- **`FormValidation`** — coordinates all fields for a validate-all-on-submit flow.
- **`.validated()` modifier** — wires up `onChange`/focus/blur/submit automatically. Does not render error UI — the consumer decides how errors appear.

```swift
@State private var email = ""
@State private var emailField = FieldValidation(.all(.notEmpty, .email))

TextField("Email", text: $email)
    .validated(emailField, text: $email)

// Render errors however you want:
ForEach(emailField.result?.errors ?? [], id: \.self) { error in
    Text(error.localizedDescription).foregroundStyle(.red)
}
```

### 3. Hard-coded error messages

Built-in validators in v1 had non-overridable localized error strings. To customize a message you had to write an entirely new validator.

**v2 solution:** `MessageRule` wraps any rule and replaces its errors with a custom message. Works on any rule — built-in, composed, or custom:

```swift
.email.message("Please enter a valid email")

AllRule.all(
    NotEmptyRule().message("Email is required"),
    EmailRule().message("That doesn't look like an email address")
)
```

### 4. Closure-based design

v1's `Validator` was a struct wrapping a closure — opaque, not inspectable, not protocol-oriented. It didn't feel like a Foundation API.

**v2 solution:** A `ValidationRule` protocol inspired by Foundation's `FormatStyle` / `ParseableFormatStyle`:

```swift
public protocol ValidationRule<Input, Output> {
    associatedtype Input
    associatedtype Output
    func validate(_ input: Input) -> ValidationResult<Output>
}
```

Each built-in validator is now its own concrete struct (`EmailRule`, `MinLengthRule`, `NotEmptyRule`, etc.) with stored properties, DocC pages, and natural `Sendable` conformance. Dot-syntax is preserved through constrained protocol extensions:

```swift
let rule: some ValidationRule<String, String> = .email
```

---

## Design Principles

### Compact and headless-first

The core `ValidationKit` target depends only on Foundation. It can be used in CLI tools, server-side Swift, unit tests — anywhere. SwiftUI support is a separate opt-in target.

### Type-safe composition

Rules compose with full type safety. The `&&` operator chains rules where the output of the first feeds the input of the second, enabling type transformations like `String -> Date`:

```swift
let rule = NotEmptyRule() && DateRule(formatter: myFormatter) && PastDateRule()
// Type: ChainedRule<ChainedRule<NotEmptyRule, DateRule>, PastDateRule>
// But used as: some ValidationRule<String, Date>
```

Nested generic types are hidden behind `some ValidationRule` — the consumer never sees them.

### Easy to extend

Implementing a custom rule is a single struct with one method:

```swift
struct PhoneNumberRule: ValidationRule {
    func validate(_ input: String) -> ValidationResult<String> { ... }
}
```

Add dot-syntax with a one-line extension. Add custom messages with `.message()`. Compose with built-in rules using `&&` and `||`. No subclassing, no registration, no boilerplate.

### Feels like Apple wrote it

The API follows patterns from SwiftUI and Foundation:
- Protocol with associated types (`FormatStyle`)
- Dot-syntax via `where Self ==` constraints (`ShapeStyle where Self == Color`)
- `@Observable` for state management
- `@Environment` for form coordination
- View modifiers for behavior attachment

---

## Package Structure

```
Sources/
  ValidationKit/          Core library (Foundation only)
    ValidationRule.swift  The protocol
    ValidationResult.swift
    ValidationError.swift
    Rules/                One file per rule
  ValidationKitUI/        SwiftUI integration (depends on ValidationKit)
    FieldValidation.swift
    FormValidation.swift
    ValidatedModifier.swift
Tests/
  ValidationKitTests/     Core rule tests
  ValidationKitUITests/   UI integration tests
```

**Target**: iOS 17+ / macOS 14+ / Swift 5.9+ / swift-tools-version 5.9

---

## Built-in Rules

| Rule | Input/Output | Description |
|------|-------------|-------------|
| `NotEmptyRule` | String -> String | Trims whitespace, rejects empty |
| `IsEmptyRule` | String -> String | Trims whitespace, requires empty |
| `EmailRule` | String -> String | WHATWG email pattern |
| `MinLengthRule` | String -> String | Minimum character count |
| `MaxLengthRule` | String -> String | Maximum character count |
| `ExactLengthRule` | String -> String | Exact character count |
| `HasPrefixRule` | String -> String | Required prefix |
| `DateRule` | String -> Date | Parse with DateFormatter |
| `PastDateRule` | Date -> Date | Must be in the past |
| `AcceptedRule` | Bool -> Bool | Must be true |
| `AnyOfRule` | String -> Result | Map to one of given options |
| `PassthroughRule` | T -> T | Always passes (identity) |

## Composition Rules

| Rule | Purpose |
|------|---------|
| `ChainedRule` (`&&`) | Sequential: output feeds next input. Short-circuits on failure. |
| `EitherRule` (`\|\|`) | Fallback: tries second if first fails. |
| `AllRule` (`.all(...)`) | Parallel: runs all, collects all errors. |
| `MessageRule` (`.message(...)`) | Decorator: replaces errors with custom message. |
