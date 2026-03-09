# Getting started

Using ValidationKit, it's easy to combine built-in rules and custom rules.

Here's how to get started.

## Basic example

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
  for error in errors {
    print(error.localizedDescription)
  }
}
```

## Built-in rules

Each rule is a concrete struct conforming to ``ValidationRule``:

* ``NotEmptyRule``: String must not be empty
* ``IsEmptyRule``: String must be empty
* ``MinLengthRule``: String length must be at least...
* ``MaxLengthRule``: String length must be at most...
* ``ExactLengthRule``: String length must be exactly...
* ``EmailRule``: String must be a valid email address
* ``DateRule``: String must be parseable as a date
* ``PastDateRule``: Date must be in the past
* ``AnyOfRule``: Value must be one of certain given options
* ``AcceptedRule``: Value must be boolean true
* ``HasPrefixRule``: String must have a certain prefix
* ``PassthroughRule``: No validation; always passes

## Dot-syntax

Built-in rules support dot-syntax via constrained protocol extensions:

```swift
let rule: some ValidationRule<String, String> = .email
let rule: some ValidationRule<String, String> = .minLength(8)
```

## Collecting multiple errors

Use ``AllRule`` to run all rules and collect every error:

```swift
let rule: AllRule<String> = .all(.notEmpty, .minLength(8), .email)
let result = rule.validate("ab")
result.errors // Contains tooShort and invalidEmail errors
```

## Custom error messages

Use `.message()` to override error messages on any rule:

```swift
let rule: AllRule<String> = .all(
  NotEmptyRule().message("Email is required"),
  EmailRule().message("That doesn't look like an email")
)
```
