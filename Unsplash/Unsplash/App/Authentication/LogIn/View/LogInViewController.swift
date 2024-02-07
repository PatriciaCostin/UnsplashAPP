//
//  LogInViewController.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import UIKit

final class LogInViewController: KeyboardAdjustableViewController, LogInView {
    var viewModel: LogInViewModel
    weak var delegate: LogInViewDelegate?
    
    private struct Constants {
        static let joinButtonFontSize: CGFloat = 14
        static let gradientLocations: [NSNumber] = [0.0, 0.15]
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var emailField: CustomTextField!
    @IBOutlet private weak var passwordField: CustomTextField!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var joinButton: UIButton!
    @IBOutlet private weak var gradientView: GradientView!
    
    // MARK: - Inititialization
    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    private func initialSetup() {
        view.clipsToBounds = true
        
        setupGradientView()
        setupTextFields()
        setupJoinButton()
    }
    
    // MARK: - UI Setup
    
    private func setupTextFields() {
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        let validateEmailField: (String) -> (isValid: Bool, errorMessage: String) = { text in
            let isEmailValid = self.viewModel.validateEmail(email: text)
            return isEmailValid ? (true, "") : (false, "Email must have letters, characters, and exceed 5 chars.")
        }
        
        let validatePasswordField: (String) -> (isValid: Bool, errorMessage: String) = { text in
            let isPasswordValid = self.viewModel.validatePassword(password: text)
            return isPasswordValid ? (true, "") : (false, "Password must have letters, characters, and exceed 5 chars.")
        }
        
        emailField.validationHandler = validateEmailField
        passwordField.validationHandler = validatePasswordField
    }
    
    private func setupGradientView() {
        gradientView.topColor = .white.withAlphaComponent(0.8)
        gradientView.bottomColor = .white
        gradientView.locations = Constants.gradientLocations
    }
    
    private func setupJoinButton() {
        let font1 = UIFont.systemFont(
            ofSize: Constants.joinButtonFontSize,
            weight: .regular
        )
        
        let font2 = UIFont.systemFont(
            ofSize: Constants.joinButtonFontSize,
            weight: .bold
        )
        
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: font1
        ]
        
        let attributes2: [NSAttributedString.Key: Any] = [
            .font: font2
        ]
        
        let attributedTitle = NSMutableAttributedString(
            string: "Don’t have an account? ",
            attributes: attributes1
        )
        let attributedString = NSAttributedString(string: "Join", attributes: attributes2)
        attributedTitle.append(attributedString)

        joinButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction private func logIn(_ sender: UIButton) {
        viewModel.logInUser(
            username: emailField.text,
            password: passwordField.text
        ) { result in
            
            switch result {
            case .success:
                self.delegate?.userDidLogInSuccessfully()
            case .failure(.cantValidate):
                self.showAlert(
                    title: "Wrong credentials",
                    message: "Please fill in the current credentials"
                )
            default: break
            }
        }
    }
    
    @IBAction private func forgotPassword(_ sender: UIButton) {
        delegate?.navigateToForgotPassword()
    }
    
    @IBAction private func joinIn(_ sender: UIButton) {
        delegate?.navigateToCreateAccount()
    }
}
