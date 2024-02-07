//
//  EmailValidator.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

import Foundation

struct EmailValidator: Validator {
    func validate(value: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return emailPredicate.evaluate(with: value)
    }
}
