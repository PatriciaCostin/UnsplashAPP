//
//  PasswordValidator.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

struct PasswordValidator: Validator {
    func validate(value: String) -> Bool {
        let passwordValidators = CompositeValidator(validators: [
            LengthValidator(minLength: 6),
            AlphaNumericValidator()
        ])
        return passwordValidators.validate(value: value)
    }
}
