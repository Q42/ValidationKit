//
//  ValidationRule.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 10/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

/// Validates a piece of input data, and returns a result with either the validated value or a validation error.
public struct Validator<Input, Output> {
  public typealias ValidationRule = (Input) -> ValidationResult<Output>

  private let validation: ValidationRule

  public init(validation: @escaping ValidationRule) {
    self.validation = validation
  }

  public func validate(input: Input) -> ValidationResult<Output> {
    validation(input)
  }
}

/// Combine two validators so that both must pass
public func && <Input, Output, OutputRight>(lhs: Validator<Input, Output>, rhs: Validator<Output, OutputRight>) -> Validator<Input, OutputRight> {
  Validator { input in
    let lhsResult = lhs.validate(input: input)

    switch lhsResult {
    case let .valid(lhsValue):
      return rhs.validate(input: lhsValue)
    case let .invalid(error):
      return .invalid(error)
    }
  }
}

/// Combine two validators so that one or both must pass
public func || <Input, Output>(lhs: Validator<Input, Output>, rhs: Validator<Input, Output>) -> Validator<Input, Output> {
  Validator { input in
    let lhsResult = lhs.validate(input: input)

    switch lhsResult {
    case let .valid(lhsValue):
      return .valid(lhsValue)
    case .invalid:
      return rhs.validate(input: input)
    }
  }
}
