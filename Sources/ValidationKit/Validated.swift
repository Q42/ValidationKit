//
//  Validated.swift
//  
//
//  Created by Mathijs on 16/03/2021.
//

import Foundation

@propertyWrapper
public struct Validated<Input, Output> {
  public var wrappedValue: Input
  let validator: Validator<Input, Output>

  public var projectedValue: ValidationResult<Output> {
    validator.validate(input: wrappedValue)
  }

  public init(
    wrappedValue: Input,
    _ validator: Validator<Input, Output>
  ) {
    self.wrappedValue = wrappedValue
    self.validator = validator
  }
}
