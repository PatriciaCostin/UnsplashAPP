//
//  SettingsViewController.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

final class SettingsViewController: UIViewController, SettingsView {
    
    var viewModel: SettingsViewModel
    weak var delegate: SettingsViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var logOutButton: CustomButton!
    
    // MARK: - Initialization
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Settings"
        tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        logOutButton.setTitleColor(.red, for: .normal)
    }
    
    private func handleDeletePersistentData() {
        self.showSpinner()
        self.viewModel.deletePersistenceData { success in
            self.hideSpinner()
            if success {
                self.showAlert(
                    title: "Persistence",
                    message: "Data successfully deleted"
                )
            } else {
                self.showAlert(
                    title: "Persistence",
                    message: "There is nothing to delete"
                )
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func changeMyPassword(_ sender: CustomButton) {
        print("Change my password")
        
        guard let navigationController else {
            return
        }
        
        self.delegate?.openChangePassword(navigationController)
    }
    
    @IBAction private func deletePersistentData(_ sender: CustomButton) {
        showAlert(
            title: "Delete persistence data",
            message: "Are you sure you want delete the data?",
            actions: [
                .init(title: "Cancel", style: .cancel, handler: nil),
                .init(title: "Delete", style: .destructive) { _ in
                    self.handleDeletePersistentData()
                }
            ]
        )
    }
    
    @IBAction private func logOut(_ sender: CustomButton) {
        showAlert(
            title: "Log out",
            message: "Are you sure you want to log out?",
            actions: [
                .init(title: "Cancel", style: .cancel, handler: nil),
                .init(title: "Log out", style: .destructive) { _ in
                    self.viewModel.logOut()
                    self.delegate?.userWantsToLogOut()
                }
            ]
        )
    }
}
