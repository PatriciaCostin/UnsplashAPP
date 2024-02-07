//
//  AuthenticationCoordinatorImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

import UIKit

final class AuthenticationCoordinator {
    weak var delegate: AuthenticationCoordinatorDelegate?
    private var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AuthenticationCoordinator {
    func rootViewController() -> UIViewController {
        let authentication = WelcomeViewFactory.create()
        authentication.delegate = self
        return authentication
    }
}

extension AuthenticationCoordinator: WelcomeViewDelegate {
    func navigateToLogIn() {
        let viewController = LogInViewFactory.create()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToCreateAccount() {
        let viewController = CreateAccountViewFactory.create()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension AuthenticationCoordinator: LogInViewDelegate {
    func navigateToForgotPassword() {
        let viewController = ForgotPasswordViewFactory.create()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func userDidLogInSuccessfully() {
        delegate?.userDidSuccessfullyAuthenticate()
    }
}

extension AuthenticationCoordinator: CreateAccountViewDelegate {
    func userDidSuccessfullyCreateAccount() {
        delegate?.userDidSuccessfullyAuthenticate()
    }
}

extension AuthenticationCoordinator: ForgotPasswordViewDelegate {
    func navigateBackToLogIn() {
        let viewController = navigationController.viewControllers.first { $0 is LogInViewController }
        if let viewController = viewController {
            navigationController.popToViewController(viewController, animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
