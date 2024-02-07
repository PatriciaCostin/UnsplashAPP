//
//  ChangePasswordViewModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 31.10.2023.
//

protocol ChangePasswordViewModel {
    func changePassword(
        oldPassword: String,
        newPassword: String,
        completion: @escaping (Result<Bool, ChangePasswordServiceError>) -> Void
    )
    func validatePassword(password: String) -> Bool
}
