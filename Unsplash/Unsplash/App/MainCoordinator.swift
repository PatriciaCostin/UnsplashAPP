//
//  MainCoordinator.swift
//  Unsplash
//
//  Created by Patricia Costin on 26.09.2023.
//

import UIKit

final class MainCoordinator {
    let navigationController: UINavigationController
    let authenticationCoordinator: AuthenticationCoordinator
    var browseCoordinator: BrowseCoordinator
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.browseCoordinator = BrowseCoordinator()
        self.authenticationCoordinator = AuthenticationCoordinator(navigationController)
        
        self.browseCoordinator.delegate = self
        self.authenticationCoordinator.delegate = self
        
        let rootViewController = authenticationCoordinator.rootViewController()
        navigationController.setViewControllers([rootViewController], animated: false)
    }
}

extension MainCoordinator: AuthenticationCoordinatorDelegate {
    func userDidSuccessfullyAuthenticate() {
        let viewController = browseCoordinator.rootViewController()
        viewController.modalPresentationStyle = .fullScreen
        
        navigationController.present(
            viewController,
            animated: true
        )
    }
}

extension MainCoordinator: BrowseCoordinatorDelegate {
    func userLogsOut() {
        let rootViewController = authenticationCoordinator.rootViewController()
        navigationController.setViewControllers([rootViewController], animated: false)
        
        navigationController.dismiss(animated: true)
    }
}
