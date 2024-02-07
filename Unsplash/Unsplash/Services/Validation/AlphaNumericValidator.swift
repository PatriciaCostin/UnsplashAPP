//
//  AlphaNumericValidator.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

struct AlphaNumericValidator: Validator {
    func validate(value: String) -> Bool {
        let hasLetters = value.rangeOfCharacter(from: .letters) != nil
        let hasDigits = value.rangeOfCharacter(from: .decimalDigits) != nil
        return hasLetters && hasDigits
    }
}
