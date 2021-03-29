//
//  Validated.swift
//  
//
//  Created by Mathijs on 16/03/2021.
//

import Foundation

@propertyWrapper
struct Validated<Input, Output> {
  var wrappedValue: Input
  let validator: Validator<Input, Output>

  var projectedValue: ValidationResult<Output> {
    validator.validate(input: wrappedValue)
  }

  init(
    wrappedValue: Input,
    _ validator: Validator<Input, Output>
  ) {
    self.wrappedValue = wrappedValue
    self.validator = validator
  }
}
