//
//  ValidationError.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 02/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

public struct ValidationError: Error, Equatable, Hashable {
  public let localizedDescription: String

  public init(localizedDescription: String) {
    self.localizedDescription = localizedDescription
  }
}

public extension ValidationError {
  /// Value should be empty
  static let isEmpty = ValidationError(localizedDescription: NSLocalizedString("is_empty", bundle: .module, comment: "Value should be empty"))

  /// Value should not be empty
  static let notEmpty = ValidationError(localizedDescription: NSLocalizedString("not_empty", bundle: .module, comment: "Value should not be empty"))

  /// Date value should be in the future
  static let dateInTheFuture = ValidationError(localizedDescription: NSLocalizedString("date_in_future", bundle: .module, comment: "Date value should be in the future"))

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

  /// Value has an invalid prefix
  static func invalidPrefix(prefix: String) -> Self {
    let format = NSLocalizedString("invalid_prefix", bundle: .module, comment: "Value has an invalid prefix")
    return ValidationError(localizedDescription: String(format: format, prefix))
  }
  /// Value could not be parsed as a valid date
  static let invalidDate = ValidationError(localizedDescription: NSLocalizedString("invalid_date", bundle: .module, comment: "Value could not be parsed as a valid date"))

  /// Value is false
  static let notAccepted = ValidationError(localizedDescription: NSLocalizedString("not_accepted", bundle: .module, comment: "Value is false"))

  /// Value is not a valid option
  static func invalidOption(option: String) -> Self {
    let format = NSLocalizedString("invalid_option", bundle: .module, comment: "Value is not a valid option")
    return ValidationError(localizedDescription: String(format: format, option))
  }
}
