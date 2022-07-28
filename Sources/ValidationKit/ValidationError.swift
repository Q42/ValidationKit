//
//  ValidationError.swift
//  ValidationKit
//
//  Created by Tim van Steenis on 02/12/2019.
//  Copyright © 2019 Q42. All rights reserved.
//

import Foundation

/// An error that occurs when input validation does not pass.
public struct ValidationError: Error, Equatable, Hashable {
  public let localizedDescription: String

  public init(localizedDescription: String) {
    self.localizedDescription = localizedDescription
  }
}
