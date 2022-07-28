//
//  Validator+Length.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 28/07/2022.
//

import Foundation

public extension Validator {
  /// The value must be at least a minimum length (greater than or equals)
  static func minLength(_ length: Int) -> Validator<String, String> {
    Validator<String, String> { input in
      if input.count >= length {
        return .valid(input)
      } else {
        return .invalid(.tooShort(minLength: length))
      }
    }
  }

  /// The value must be equal or under a maximum length
  static func maxLength(_ length: Int) -> Validator<String, String> {
    Validator<String, String> { input in
      if input.count <= length {
        return .valid(input)
      } else {
        return .invalid(.tooLong(maxLength: length))
      }
    }
  }

  /// The value must have an exact length
  static func exactLength(_ length: Int) -> Validator<String, String> {
    Validator<String, String> { input in
      if input.count == length {
        return .valid(input)
      } else {
        return .invalid(.notExactLength(exactLength: length))
      }
    }
  }
}

public extension ValidationError {
  /// Value is too short
  static func tooShort(minLength: Int) -> Self {
    let format = NSLocalizedString("too_short", bundle: .module, comment: "Value is too short")
    return ValidationError(localizedDescription: String(format: format, minLength))
  }

  /// Value is too long
  static func tooLong(maxLength: Int) -> Self {
    let format = NSLocalizedString("too_long", bundle: .module, comment: "Value is too long")
    return ValidationError(localizedDescription: String(format: format, maxLength))
  }

  /// Value should be of an exact length
  static func notExactLength(exactLength: Int) -> Self {
    let format = NSLocalizedString("not_exact_length", bundle: .module, comment: "Value should be of an exact length")
    return ValidationError(localizedDescription: String(format: format, exactLength))
  }
}
