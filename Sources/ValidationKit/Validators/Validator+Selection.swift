//
//  Validator+Selection.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 28/07/2022.
//

import Foundation

public extension Validator {
  /// The value must be one of certain given options
  static func anyOf<Result>(options: [(String, Result)]) -> Validator<String, Result> {
    Validator<String, Result> { input in
      if let option = options.first(where: { $0.0 == input }) {
        return .valid(option.1)
      } else {
        return .invalid(.invalidOption(option: input))
      }
    }
  }
}

public extension ValidationError {
  /// Value is not a valid option
  static func invalidOption(option: String) -> Self {
    let format = NSLocalizedString("invalid_option", bundle: .module, comment: "Value is not a valid option")
    return ValidationError(localizedDescription: String(format: format, option))
  }
}
