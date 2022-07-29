//
//  Validator+String.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 28/07/2022.
//

import Foundation

public extension Validator {
  /// The property must have a certain string prefix
  static func hasPrefix(_ prefix: String) -> Validator<String, String> {
    Validator<String, String> { input in
      if input.hasPrefix(prefix) {
        return .valid(input)
      } else {
        return .invalid(.invalidPrefix(prefix: prefix))
      }
    }
  }
}

public extension ValidationError {
  /// Value has an invalid prefix
  static func invalidPrefix(prefix: String) -> Self {
    let format = NSLocalizedString("invalid_prefix", bundle: .module, comment: "Value has an invalid prefix")
    return ValidationError(localizedDescription: String(format: format, prefix))
  }
}
