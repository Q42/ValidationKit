//
//  Validator+Empty.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 28/07/2022.
//

import Foundation

public extension Validator where Input == String?, Output == String {
  /// The value must be empty
  static var isEmpty: Validator<String?, String> {
    Validator<String?, String> { input in
      let input = input?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
      if input.isEmpty {
        return .valid(input)
      } else {
        return .invalid(.isEmpty)
      }
    }
  }

  /// The value must not be empty
  static var notEmpty: Validator<String?, String> {
    Validator<String?, String> { input in
      let input = input?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
      if !input.isEmpty {
        return .valid(input)
      } else {
        return .invalid(.notEmpty)
      }
    }
  }
}

public extension Validator where Input == String, Output == String {
  /// The value must be empty
  static var isEmpty: Validator<String, String> {
    Validator<String, String> { input in
      let input = input.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      if input.isEmpty {
        return .valid(input)
      } else {
        return .invalid(.isEmpty)
      }
    }
  }

  /// The value must not be empty
  static var notEmpty: Validator<String, String> {
    Validator<String, String> { input in
      let input = input.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      if !input.isEmpty {
        return .valid(input)
      } else {
        return .invalid(.notEmpty)
      }
    }
  }
}

public extension ValidationError {
  /// Value should be empty
  static let isEmpty = ValidationError(localizedDescription: NSLocalizedString("is_empty", bundle: .module, comment: "Value should be empty"))

  /// Value should not be empty
  static let notEmpty = ValidationError(localizedDescription: NSLocalizedString("not_empty", bundle: .module, comment: "Value should not be empty"))
}
