# ``ValidationKit``

A lightweight Swift library for validating user input, for example in forms.

## Overview

Using ValidationKit, you can easily combine different validation rules together.
For example, to validate a Tweet body, you could write:

```swift
import ValidationKit

// Rules can be combined using the operators `&&` and `||`
let tweetRule = NotEmptyRule() && MaxLengthRule(length: 280)

let tweet = "Hello, world!"
let result = tweetRule.validate(tweet)

switch result {
case .valid(let value):
  print("Tweet '\(value)' is valid")
case .invalid(let errors):
  print("Tweet did not validate: \(errors.map(\.localizedDescription).joined(separator: ", "))")
}
```

To collect all errors at once, use `AllRule`:

```swift
let rule: AllRule<String> = .all(.notEmpty, .minLength(8), .email)
let result = rule.validate("ab")
result.errors // [tooShort, invalidEmail]
```

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:CustomValidators>
