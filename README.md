# ValidationKit

A Swift library for validating user input, for example in forms.

## Usage

Using the built in validators:

```swift
import ValidationKit

let tweetValidator: Validator = .notEmpty && .maxLength(1) && .maxLength(280)

let tweet = "hello world"
let result = tweetValidator.validate(input: tweet)
result.isValid // true

switch result {
case .valid(let value):
  print("Tweet '\(value)' is valid")
case .invalid(let error):
  print(String(format: "Tweet dit not validate: %@", error.localizedDescription)
}
```

Implementing a custom validator:

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

## Releases

 - 0.0.1 - 2021-03-28 - Initial public release
 - 0.0.0 - 2019-12-02 - Initial private version for a project at [Q42](http://q42.com)

## Licence & Credits

ValidationKit is written by [Mathijs Bernson](https://twitter.com/mathijsbernson) and [Tim van Steenis](https://github.com/timvansteenis).

It is available under the [MIT license](https://github.com/Q42/ValidationKit/blob/main/LICENSE), so feel free to use it in commercial and non-commercial projects.
