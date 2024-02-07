//
//  WelcomeViewFactory.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

struct WelcomeViewFactory {
    
    static func create() -> WelcomeView {
        let viewModel = WelcomeViewModelImp()
        return WelcomeViewController(
            viewModel: viewModel
        )
    }
}
