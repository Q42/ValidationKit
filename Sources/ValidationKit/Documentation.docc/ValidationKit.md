# ``ValidationKit``

A lightweight Swift library for validating user input, for example in forms.

## Overview

Using ValidationKit, you can easily combine different input validations together.
For example, to validate a Tweet body, you could write:

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

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:CustomValidators>
