//
//  Validator+Email.swift
//  ValidationKit
//
//  Created by Mathijs Bernson on 25/05/2023.
//

import Foundation

private let emailPattern = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
  "\\@" +
  "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
  "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
  ")+"

public extension Validator {
  /// Validates whether the value is a valid e-mail address, according to the WHATWG HTML living standard.
  ///
  /// A valid email address is a string that matches the email production of the following ABNF, the character set for which is Unicode. This ABNF implements the extensions described in RFC 1123.
  ///
  /// ```
  /// email         = 1*( atext / "." ) "@" label *( "." label )
  /// label         = let-dig [ [ ldh-str ] let-dig ]  ; limited to a length of 63 characters by RFC 1034 section 3.5
  /// atext         = < as defined in RFC 5322 section 3.2.3 >
  /// let-dig       = < as defined in RFC 1034 section 3.5 >
  /// ldh-str       = < as defined in RFC 1034 section 3.5 >
  /// ```
  ///
  /// Note: This requirement is a willful violation of RFC 5322, which defines a syntax for email addresses that is simultaneously too strict (before the "@" character), too vague (after the "@" character), and too lax (allowing comments, whitespace characters, and quoted strings in manners unfamiliar to most users) to be of practical use here.
  ///
  /// Reference: https://html.spec.whatwg.org/multipage/input.html#valid-e-mail-address
  static var email: Validator<String, String> {
    Validator<String, String> { input in
      if let range = input.range(of: emailPattern, options: .regularExpression) {
        let output = String(input[range])
        return .valid(output)
      } else {
        return .invalid(.invalidEmail)
      }
    }
  }
}
public extension ValidationError {
  static let invalidEmail = ValidationError(localizedDescription: NSLocalizedString("invalid_email", comment: "Invalid e-mail address error"))
}
