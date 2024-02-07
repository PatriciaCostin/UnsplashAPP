//
//  ForgotPasswordViewController.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import UIKit

final class ForgotPasswordViewController: KeyboardAdjustableViewController, ForgotPasswordView {
    
    var viewModel: ForgotPasswordViewModel
    weak var delegate: ForgotPasswordViewDelegate?
    
    @IBOutlet private weak var emailField: CustomTextField!
    
    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpEmailTextField()
    }
    
    private func setUpEmailTextField() {
        emailField.placeholder = "Enter your email"
        
        let validateEmailField: (String) -> (isValid: Bool, errorMessage: String) = { text in
            return self.viewModel.validateEmail(email: text) ? (true, "") : (false, "Email must have letters, characters, and exceed 5 chars.")
        }
        
        emailField.validationHandler = validateEmailField
    }
    
    // MARK: - Actions
    
    @IBAction private func backToLogIn(_ sender: UIButton) {
        delegate?.navigateBackToLogIn()
    }
    
    @IBAction private func resetPassword(_ sender: UIButton) {
        
        let username = emailField.text
        
        viewModel.resetPassword(for: username) { result in
            switch result {
            case .success(let newPassword):
                self.showAlert(
                    title: "Password reset",
                    message: "Your new password is: \(newPassword)",
                    actions: [
                        .init(title: "Ok", style: .default) { _ in
                            self.delegate?.navigateBackToLogIn()
                        }
                    ]
                )
            case .failure(.cantValidate):
                self.showAlert(
                    title: "Password reset",
                    message: "No user is registered with this \(username) email address."
                )
            default:
                break
            }
        }
    }
}
