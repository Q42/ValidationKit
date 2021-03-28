# ValidationKit

A Swift library for validating user input, for example in forms.

## Usage

```swift
import ValidationKit

let titleValidator: Validator = .notEmpty && .maxLength(140)

switch titleValidator.validate(input: title) {
case .valid(let value):
  print("title \(value) is valid")
case .invalid(let error):
  print(String(format: "title: %@", error.localizedDescription)
}
```

## Releases

 - 0.0.1 - 2021-03-28 - Initial public release
 - 0.0.0 - 2019-12-02 - Initial private version for a project at [Q42](http://q42.com)

## Licence & Credits

ValidationKit is written by [Mathijs Bernson](https://twitter.com/mathijsbernson) and [Tim van Steenis](https://github.com/timvansteenis).

It is available under the [MIT license](https://github.com/Q42/ValidationKit/blob/main/LICENSE), so feel free to use it in commercial and non-commercial projects.
