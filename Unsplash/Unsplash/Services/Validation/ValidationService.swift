//
//  ValidationService.swift
//  Unsplash
//
//  Created by Ion Belous on 03.11.2023.
//

protocol ValidationService {
    func validateEmail(email: String) -> Bool
    func validatePassword(password: String) -> Bool
}
