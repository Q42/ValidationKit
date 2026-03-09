# Implementing a custom rule

A custom rule is a struct conforming to ``ValidationRule``.

## Example

```swift
struct DutchPostalCodeRule: ValidationRule {
  func validate(_ input: String) -> ValidationResult<String> {
    if let range = input.range(of: #"^\d{4}\s?[a-zA-Z]{2}$"#, options: .regularExpression) {
      let output = String(input[range])
      return .valid(output)
    } else {
      return .invalid(ValidationError(localizedDescription: "Invalid Dutch postal code"))
    }
  }
}

// Add dot-syntax support:
extension ValidationRule where Self == DutchPostalCodeRule {
  static var dutchPostalCode: DutchPostalCodeRule { DutchPostalCodeRule() }
}
```

We can then use it like so:

```swift
let rule = NotEmptyRule() && DutchPostalCodeRule()
let result = rule.validate("2516 AH") // .valid("2516 AH")
```

## Type-transforming rules

The input of a rule does not have to be the same type as its output.
For example, this rule converts a string into an array of digits:

```swift
struct NumericCodeRule: ValidationRule {
  func validate(_ input: String) -> ValidationResult<[Int]> {
    let numericCode: [Int] = input
      .map(String.init)
      .compactMap(Int.init)

    if numericCode.count == input.count {
      return .valid(numericCode)
    } else {
      return .invalid(ValidationError(localizedDescription: "Not a numeric code"))
    }
  }
}
```

Chain it with other rules using `&&`:

```swift
let rule = ExactLengthRule(length: 8) && NumericCodeRule()
let result = rule.validate("13374242")
result.isValid // true
result.value   // [1, 3, 3, 7, 4, 2, 4, 2]
```
