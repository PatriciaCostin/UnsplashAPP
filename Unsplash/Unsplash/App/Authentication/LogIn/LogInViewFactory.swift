//
//  LogInViewFactory.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

struct LogInViewFactory {
    
    static func create() -> LogInView {
        let storage = SecureStorage()
        let validationService = DefaultValidationService()
        let viewModel = LogInViewModelImp(
            storage: storage,
            validationService: validationService
        )
        return LogInViewController(
            viewModel: viewModel
        )
    }
}
