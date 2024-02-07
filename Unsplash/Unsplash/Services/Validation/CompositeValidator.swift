//
//  CompositeValidator.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

struct CompositeValidator: Validator {
    private let validators: [Validator]
    
    init(validators: [Validator]) {
        self.validators = validators
    }
    
    func validate(value: String) -> Bool {
        for validator in validators {
            if !validator.validate(value: value) {
                return false
            }
        }
        return true
    }
}
