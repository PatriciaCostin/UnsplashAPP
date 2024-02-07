//
//  ChangePasswordFactory.swift
//  Unsplash
//
//  Created by Patricia Costin on 31.10.2023.
//

import UIKit

struct ChangePasswordViewFactory {
    static func create() -> ChangePasswordView {
        let storage = SecureStorage()
        let validationService = DefaultValidationService()
        let changePasswordService = ChangePasswordServiceImp(storage: storage)
        let viewModel = ChangePasswordViewModelImp(
            changePasswordService: changePasswordService,
            validationService: validationService
        )
        return ChangePasswordViewController(
            viewModel: viewModel
        )
    }
}
