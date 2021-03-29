//
//  Validators.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 10/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

public extension Validator {
  /// The value must be empty
  static var isEmpty: Validator<String?, String> {
    Validator<String?, String> { input in
      let val = input?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""

      if val.isEmpty {
        return .valid(val)
      } else {
        return .invalid(.isEmpty)
      }
    }
  }

  /// The value must not be empty
  static var notEmpty: Validator<String?, String> {
    Validator<String?, String> { input in
      if let input = input?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !input.isEmpty {
        return .valid(input)
      } else {
        return .invalid(.notEmpty)
      }
    }
  }

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

public extension Validator where Input == Output {
  static var none: Validator {
    Validator { .valid($0) }
  }
}
