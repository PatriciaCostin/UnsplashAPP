//
//  ChangePasswordServiceError.swift
//  Unsplash
//
//  Created by Patricia Costin on 01.11.2023.
//

enum ChangePasswordServiceError: Error {
    case retrievingUsersError
    case noLoggedInUserAvailable
    case oldPasswordDoesNotMatch
    case invalidFields
}
