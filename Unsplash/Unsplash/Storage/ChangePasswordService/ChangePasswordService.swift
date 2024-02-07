//
//  ChangePasswordService.swift
//  Unsplash
//
//  Created by Patricia Costin on 01.11.2023.
//

protocol ChangePasswordService {
    func changePassword(
        oldPassword: String,
        newPassword: String,
        completion: @escaping (Result<Bool, ChangePasswordServiceError>) -> Void
    )
}
