# Getting started

Using ValidationKit, it's easy to combine built-in validators and custom validators.

Here's how to get started.

## Basic example

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

## Built-in validators

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
