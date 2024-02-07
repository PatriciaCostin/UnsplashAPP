//
//  LengthValidator.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

struct LengthValidator: Validator {
    private let minLength: Int
    init(minLength: Int) {
        self.minLength = minLength
    }
    
    func validate(value: String) -> Bool {
        return value.count >= minLength
    }
}
