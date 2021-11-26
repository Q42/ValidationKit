# ValidationKit

A lightweight Swift library for validating user input, for example in forms.

## Usage

### Example: Using the built in validators

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

### Example: Using the @Validated property wrapper

```swift
struct Person {
  @Validated(.notEmpty)
  var name: String? = nil

  @Validated(.notEmpty && .exactLength(6))
  var dutchPostalCode: String? = nil
}

let person = Person(name: "Mathijs", dutchPostalCode: "8049BW")
// Use the regular value of the property
person.name // "Mathijs"
// You can access the validation result by using the $ (wrapped value).
person.$name.isValid // True
person.$name.value // Gets the validated and normalized value, or nil if invalid.
```

## Validators

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

let postalCodeValidator: Validator = .notEmpty && .isDutchPostalCode
let result = postalCodeValidator.validate(input: "2516 AH") // Equals ValidationResult.valid("2516 AH")
```

### Internationalization

This library contains localized strings for English and Dutch. Pull requests that add support for additional languages are welcome.

If you desire a different error text for a certain validation, you must write your own validator and validation error. 
See the files [Validators.swift](https://github.com/Q42/ValidationKit/blob/main/Sources/ValidationKit/Validators.swift) and [ValidationError.swift](https://github.com/Q42/ValidationKit/blob/main/Sources/ValidationKit/ValidationError.swift) for examples how to do this.

## Releases

 - 0.0.1 - 2021-03-28 - Initial public release
 - 0.0.0 - 2019-12-02 - Initial private version for a project at [Q42](http://q42.com)

## Licence & Credits

ValidationKit is written by [Mathijs Bernson](https://twitter.com/mathijsbernson) and [Tim van Steenis](https://github.com/timvansteenis).

It is available under the [MIT license](https://github.com/Q42/ValidationKit/blob/main/LICENSE), so feel free to use it in commercial and non-commercial projects.
