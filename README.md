# ValidationKit

A lightweight Swift library for validating user input, for example in forms.

## Usage

### Using the built in validators

```swift
import ValidationKit

// Validators can be combined using the operators `&&` and `||`
let tweetValidator: Validator = .notEmpty && .maxLength(280)

let tweet = "Hello, world!"
let result = tweetValidator.validate(input: tweet)

switch result {
case .valid(let value):
  print("Tweet '\(value)' is valid")
case .invalid(let error):
  print(String(format: "Tweet did not validate: %@", error.localizedDescription))
}
```

The built-in validators are:

* `isEmpty`: String must be empty
* `notEmpty`: String must not be empty
* `minLength(_ length: Int)`: String length must be greater than or equal...
* `maxLength(_ length: Int)`: String length must be less than or equal...
* `exactLength(_ length: Int)`: String length must be exactly...
* `isDate(formatter: DateFormatter)`: String must be parsable as a date using the given formatter
* `isInThePast`: Date must be in the past
* `anyOf`: Value must be one of certain given options
* `accepted`: Value must be boolean true
* `hasPrefix`: String must have a certain prefix

### Implementing a custom validator

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

### Internationalization

This library contains localized strings for English and Dutch. Pull requests that add support for additional languages are welcome.

If you desire a different error text for a certain validation, you must write your own validator and validation error. 
See the files [Validators.swift](https://github.com/Q42/ValidationKit/blob/main/Sources/ValidationKit/Validators.swift) and [ValidationError.swift](https://github.com/Q42/ValidationKit/blob/main/Sources/ValidationKit/ValidationError.swift) for examples how to do this.

## Releases

- 1.0.0 - 2023-05-25 - After more than two years since the public release, and having been used in multiple production projects, it is time for a 1.0 release!
- 0.0.1 - 2021-03-28 - Initial public release
- 0.0.0 - 2019-12-02 - Initial private version for a project at [Q42](http://q42.com)

## Licence & Credits

ValidationKit is written by [Mathijs Bernson](https://twitter.com/mathijsbernson) and [Tim van Steenis](https://github.com/timvansteenis).

It is available under the [MIT license](https://github.com/Q42/ValidationKit/blob/main/LICENSE), so feel free to use it in commercial and non-commercial projects.
