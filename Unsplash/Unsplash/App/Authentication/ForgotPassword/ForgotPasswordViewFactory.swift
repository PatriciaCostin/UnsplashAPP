//
//  ForgotPasswordViewFactory.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

struct ForgotPasswordViewFactory {
    
    static func create() -> ForgotPasswordView {
        let storage = SecureStorage()
        let validationService = DefaultValidationService()
        let viewModel = ForgotPasswordViewModelImp(
            storage: storage,
            validationService: validationService
        )
        return ForgotPasswordViewController(
            viewModel: viewModel
        )
    }
}
