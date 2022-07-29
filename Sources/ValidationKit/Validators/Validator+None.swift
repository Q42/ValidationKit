//
//  Validator+None.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 10/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

/// Does not validate anything and passes the input as the output
public extension Validator where Input == Output {
  static var none: Validator {
    Validator { .valid($0) }
  }
}
