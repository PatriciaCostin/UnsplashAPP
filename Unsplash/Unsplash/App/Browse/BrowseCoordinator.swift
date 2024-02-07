//
//  BrowseCoordinator.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//
import UIKit

final class BrowseCoordinator {
    
    weak var delegate: BrowseCoordinatorDelegate?
    
    func rootViewController() -> UIViewController {
        // Browse
        let browse = BrowseViewFactory.create()
        browse.delegate = self
        let browseNavigationController = UINavigationController(rootViewController: browse)
        
        // Likes
        let likes = LikesFactory.create()
        likes.delegate = self
        let likesNavigationController = UINavigationController(rootViewController: likes)
        
        // Settings
        let settings = SettingsFactory.create()
        settings.delegate = self
        let settingsNavigationController = UINavigationController(rootViewController: settings)
        
        let tabbar = UITabBarController()
        tabbar.tabBar.tintColor = UIColor(named: "mainColor")
        tabbar.setViewControllers([browseNavigationController, likesNavigationController, settingsNavigationController], animated: true)
        
        return tabbar
        
    }
}

extension BrowseCoordinator: BrowseViewDelegate {
    
    func openPictureDetails(_ navigationController: UINavigationController, model: PictureModel) {
        let pictureDetails = PictureDetailsFactory.create(with: model)
        pictureDetails.delegate = self
        pictureDetails.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(pictureDetails, animated: true)
    }
}

extension BrowseCoordinator: PictureDetailsViewDelegate {
}

extension BrowseCoordinator: LikesViewDelegate {
}

extension BrowseCoordinator: SettingsViewDelegate {
    func userWantsToLogOut() {
        delegate?.userLogsOut()
    }
}

extension BrowseCoordinator: ChangePasswordDelegate {
    func openChangePassword(_ navigationController: UINavigationController) {
        let changePasswordScreen = ChangePasswordViewFactory.create()
        changePasswordScreen.delegate = self
        navigationController.pushViewController(changePasswordScreen, animated: true)
    }
}
