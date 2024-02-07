//
//  CreateAccountViewModel.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

protocol CreateAccountViewModel {
    func createUser(
        username: String,
        password: String,
        completion: @escaping (Result<Bool, AccountError>) -> Void
    )
    func validateEmail(email: String) -> Bool
    func validatePassword(password: String) -> Bool
}
