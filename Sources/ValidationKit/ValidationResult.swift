//
//  ValidationResult.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 02/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

public enum ValidationResult<Value> {
  case valid(Value)
  case invalid(ValidationError)
}

extension ValidationResult: Sendable where Value: Sendable {}

public extension ValidationResult {
  /// The validation error, or nil if the value is valid
  var error: ValidationError? {
    if case let .invalid(error) = self {
      return error
    } else {
      return nil
    }
  }

  var isValid: Bool {
    if case .valid = self {
      return true
    } else {
      return false
    }
  }

  /// The validated value, or nil if the value is invalid
  var value: Value? {
    if case let .valid(value) = self {
      return value
    } else {
      return nil
    }
  }
}
