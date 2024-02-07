//
//  DefaultValidationService.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

struct DefaultValidationService: ValidationService {
    func validateEmail(email: String) -> Bool {
        return EmailValidator().validate(value: email)
    }
    
    func validatePassword(password: String) -> Bool {
        let passwordValidators = CompositeValidator(validators: [
            LengthValidator(minLength: 6),
            AlphaNumericValidator()
        ])
        return passwordValidators.validate(value: password)
    }
}
