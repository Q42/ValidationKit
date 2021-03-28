//
//  ValidationError.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 02/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

public enum ValidationError: Error, Equatable, Hashable, LocalizedError {
  /// Value should be empty
  case isEmpty
  /// Value should not be empty
  case notEmpty
  /// Date value should be in the future
  case dateInTheFuture
  /// Value is too short
  case tooShort(Int)
  /// Value is too long
  case tooLong(Int)
  /// Value should be of an exact length
  case notExactLength(Int)
  /// Value has an invalid prefix
  case invalidPrefix(String)
  /// Value could not be parsed as a valid date
  case invalidDate
  /// Value is false
  case notAccepted
  /// Value is not a valid option
  case invalidOption(String)

  public var errorDescription: String? {
    switch self {
    case .isEmpty:
      return NSLocalizedString("is_empty", bundle: .module, comment: "Value should be empty")
    case .notEmpty:
      return NSLocalizedString("not_empty", bundle: .module, comment: "Value should not be empty")
    case .dateInTheFuture:
      return NSLocalizedString("date_in_future", bundle: .module, comment: "Date value should be in the future")
    case .tooShort(let minLength):
      let format = NSLocalizedString("too_short", bundle: .module, comment: "Value is too short")
      return String(format: format, minLength)
    case .tooLong(let maxLength):
      let format = NSLocalizedString("too_long", bundle: .module, comment: "Value is too long")
      return String(format: format, maxLength)
    case .notExactLength(let exactLength):
      let format = NSLocalizedString("not_exact_length", bundle: .module, comment: "Value should be of an exact length")
      return String(format: format, exactLength)
    case .invalidPrefix(let prefix):
      let format = NSLocalizedString("invalid_prefix", bundle: .module, comment: "Value has an invalid prefix")
      return String(format: format, prefix)
    case .invalidDate:
      return NSLocalizedString("invalid_date", bundle: .module, comment: "Value could not be parsed as a valid date")
    case .notAccepted:
      return NSLocalizedString("not_accepted", bundle: .module, comment: "Value is false")
    case .invalidOption(let option):
      let format = NSLocalizedString("invalid_option", bundle: .module, comment: "Value is not a valid option")
      return String(format: format, option)
    }
  }
}
