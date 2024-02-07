//
//  ForgotPasswordViewModel.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

protocol ForgotPasswordViewModel {
    func resetPassword(
        for username: String,
        completion: @escaping (Result<String, AccountError>) -> Void
    )
    func validateEmail(email: String) -> Bool
}
