//
//  ChangePasswordViewController.swift
//  Unsplash
//
//  Created by Patricia Costin on 31.10.2023.
//

import UIKit

final class ChangePasswordViewController: KeyboardAdjustableViewController, ChangePasswordView {
    weak var delegate: ChangePasswordDelegate?
    var viewModel: ChangePasswordViewModel
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var oldPassword: CustomTextField!
    @IBOutlet private weak var newPassword: CustomTextField!
    @IBOutlet private weak var repeatedNewPassword: CustomTextField!
    
    // MARK: - Initialization
    
    init(viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    func setupTextFields() {
        oldPassword.placeholder = "Old password"
        newPassword.placeholder = "New password"
        repeatedNewPassword.placeholder = "Repeat new password"
        oldPassword.isSecureTextEntry = true
        newPassword.isSecureTextEntry = true
        repeatedNewPassword.isSecureTextEntry = true
        
        let validatePassword: (String) -> (isValid: Bool, errorMessage: String) = { text in
            let isPasswordValid = self.viewModel.validatePassword(password: text)
            return isPasswordValid ? (true, "") : (false, "Password must have letters, characters, and exceed 5 chars.")
        }
        
        let validateMatchingPasswords: (String) -> (isValid: Bool, errorMessage: String) = { text in
            return (text != self.newPassword.text) ? (false, "Passwords must match") : (true, "")
        }
        
        oldPassword.validationHandler = validatePassword
        newPassword.validationHandler = validatePassword
        repeatedNewPassword.validationHandler = validateMatchingPasswords
    }
    
    @IBAction private func changePassword(_ sender: Any) {
        let newPassword = newPassword.text
        let repeatedNewPassword = self.repeatedNewPassword.text
        let oldPassword = self.oldPassword.text
        
        guard newPassword == repeatedNewPassword else {
            showAlert(title: "Failed to change password", message: "New passwords are not matching.")
            return
        }

        showSpinner()

        self.viewModel.changePassword(
            oldPassword: oldPassword,
            newPassword: repeatedNewPassword
        ) { [weak self] result in
            
            guard let self else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.hideSpinner()
                switch result {
                case .success:
                    self.showAlert(title: "Password", message: "Password was successfully updated.")
                    self.oldPassword.text = ""
                    self.newPassword.text = ""
                    self.repeatedNewPassword.text = ""
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: ChangePasswordServiceError) {
        switch error {
        case .retrievingUsersError:
            self.showAlert(title: "Failed to change password", message: "Could not retrieve users from storage.")
        case .noLoggedInUserAvailable:
            self.showAlert(title: "Failed to change password", message: "Could not find user with current logged in token.")
        case .oldPasswordDoesNotMatch:
            self.showAlert(title: "Failed to change password", message: "Inserted old password is not matching your current password.")
        case .invalidFields:
            self.showAlert(title: "Error", message: "Invalid fields")
        }
    }
}
