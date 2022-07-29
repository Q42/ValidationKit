# Implementing a custom validator

A custom validator can be implemented as follows.

The example uses a regular expression, but of course you are free to use any kind of logic you want.

```swift
public extension Validator {
  static var isDutchPostalCode: Validator<String, String> {
    Validator<String, String> { input in
      if let range = input.range(of: #"^\d{4}\s?[a-zA-Z]{2}$"#, options: .regularExpression) {
        let output = String(input[range])
        return .valid(output)
      } else {
        return .invalid(.invalidDutchPostalCode)
      }
    }
  }
}

public extension ValidationError {
  static let invalidDutchPostalCode = ValidationError(localizedDescription: NSLocalizedString("Invalid Dutch postal code", comment: "Validation error text"))
}
```

We can then use it like so:

```swift
let postalCodeValidator: Validator = .notEmpty && .isDutchPostalCode
let result = postalCodeValidator.validate(input: "2516 AH") // Equals ValidationResult.valid("2516 AH")
```

The input of a validator does not have to be of the same type as its output. 
For example, this validator converts a string into an array of digits (integers from 0-9).

```swift
extension Validator {
  /// Validates whether a string consists of a sequence of digits (0-9).
  static var numericCode: Validator<String, [Int]> {
    Validator<String, [Int]> { input in
      let numericCode: [Int] = input
        .map(String.init) // Convert the string to individual characters first
        .compactMap(Int.init)

      if numericCode.count == input.count {
        return .valid(numericCode)
      } else {
        return .invalid(.notNumericCode)
      }
    }
  }
}

extension ValidationError {
  static let notNumericCode = ValidationError(localizedDescription: NSLocalizedString("Not a numeric code", comment: "Validation error text"))
}
```

To validate an 8-digit code, we can use it like so:

```swift
let validator: Validator = .exactLength(8) && .numericCode
let result = validator.validate(input: "13374242)
result.isValid // True
result.value // [1, 3, 3, 7, 4, 2, 4, 2]
```
