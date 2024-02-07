//
//  CreateAccountViewController.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import UIKit

final class CreateAccountViewController: KeyboardAdjustableViewController, CreateAccountView {
    var viewModel: CreateAccountViewModel
    weak var delegate: CreateAccountViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var emailField: CustomTextField!
    @IBOutlet private weak var passwordField: CustomTextField!
    @IBOutlet private weak var repeatPasswordField: CustomTextField!
    
    // MARK: - Initialization
    
    init(viewModel: CreateAccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    // MARK: - Setup
    
    func setupTextFields() {
        emailField.placeholder = "Email"
        passwordField.placeholder = "Enter your password"
        repeatPasswordField.placeholder = "Repeat your password"
        passwordField.isSecureTextEntry = true
        repeatPasswordField.isSecureTextEntry = true
        
        let validateEmailField: (String) -> (isValid: Bool, errorMessage: String) = { text in
            return self.viewModel.validateEmail(email: text) ? (true, "") : (false, "Email must have letters, characters, and exceed 5 chars.")
        }
        
        let validatePasswordField: (String) -> (isValid: Bool, errorMessage: String) = { text in
            let isPasswordValid = self.viewModel.validatePassword(password: text)
            return isPasswordValid ? (true, "") : (false, "Password must have letters, characters, and exceed 5 chars.")
        }
        
        let validateMatchingPasswords: (String) -> (isValid: Bool, errorMessage: String) = { text in
            return (text != self.passwordField.text) ? (false, "Passwords must match") : (true, "")
        }
        
        emailField.validationHandler = validateEmailField
        passwordField.validationHandler = validatePasswordField
        repeatPasswordField.validationHandler = validateMatchingPasswords
    }
    
    // MARK: - Actions
    
    @IBAction private func createAccount(_ sender: UIButton) {
        
        guard passwordField.text == repeatPasswordField.text else {
            showAlert(title: "Error", message: "Passwords don't match.")
            return
        }
        
        viewModel.createUser(
            username: emailField.text,
            password: passwordField.text
        ) { result in
            
            switch result {
            case .success:
                self.delegate?.userDidSuccessfullyCreateAccount()
            case .failure(.userTaken):
                self.showAlert(title: "Error", message: "The username is taken")
            case .failure(.cantCreate):
                self.showAlert(title: "Error", message: "Can't create")
            case .failure(.cantValidate):
                self.showAlert(title: "Error", message: "Invalid fields")
            }
        }
    }
}
