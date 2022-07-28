//
//  Validator+Date.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 28/07/2022.
//

import Foundation

public extension Validator {
  /// The value must be able to be parsed as a date
  static func isDate(formatter: DateFormatter) -> Validator<String, Date> {
    Validator<String, Date> { input in
      if let date = formatter.date(from: input) {
        return .valid(date)
      } else {
        return .invalid(.invalidDate)
      }
    }
  }

  /// The date value must be in the past
  static var isInThePast: Validator<Date, Date> {
    Validator<Date, Date> { input in
      if input < Date() {
        return .valid(input)
      } else {
        return .invalid(.dateInTheFuture)
      }
    }
  }
}

public extension ValidationError {
  /// Value could not be parsed as a valid date
  static let invalidDate = ValidationError(localizedDescription: NSLocalizedString("invalid_date", bundle: .module, comment: "Value could not be parsed as a valid date"))

  /// Date value should be in the future
  static let dateInTheFuture = ValidationError(localizedDescription: NSLocalizedString("date_in_future", bundle: .module, comment: "Date value should be in the future"))
}
