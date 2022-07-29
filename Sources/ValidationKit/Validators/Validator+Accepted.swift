//
//  Validator+Accepted.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 28/07/2022.
//

import Foundation

public extension Validator {
  /// The property must be boolean true
  static var accepted: Validator<Bool, Bool> {
    Validator<Bool, Bool> { input in
      if input {
        return .valid(input)
      } else {
        return .invalid(.notAccepted)
      }
    }
  }
}

public extension ValidationError {
  /// Value is false
  static let notAccepted = ValidationError(localizedDescription: NSLocalizedString("not_accepted", bundle: .module, comment: "Value is false"))
}
