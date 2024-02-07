//
//  CreateAccountError.swift
//  Unsplash
//
//  Created by Ion Belous on 19.10.2023.
//

enum AccountError: Error {
    case userTaken
    case cantValidate
    case cantCreate
}
