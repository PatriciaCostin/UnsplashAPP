//
//  CreateAccountViewFactory.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

struct CreateAccountViewFactory {
    
    static func create() -> CreateAccountView {
        let storage = SecureStorage()
        let validationService = DefaultValidationService()
        let viewModel = CreateAccountViewModelImp(
            storage: storage,
            validationService: validationService
        )
        return CreateAccountViewController(
            viewModel: viewModel
        )
    }
}
