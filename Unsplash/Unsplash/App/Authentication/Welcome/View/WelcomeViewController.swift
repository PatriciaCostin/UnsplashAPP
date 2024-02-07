//
//  WelcomeViewController.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//
import UIKit

final class WelcomeViewController: UIViewController, WelcomeView, UITextViewDelegate {
    weak var delegate: WelcomeViewDelegate?
    var viewModel: WelcomeViewModel
    @IBOutlet private var splashImageBottomImage: NSLayoutConstraint!
    @IBOutlet private weak var termsAndPrivacyTextView: UITextView!
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splashImageBottomImage.isActive = true
        setupTermsAndPrivacyTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.isUserLoggedIn() {
            delegate?.userDidLogInSuccessfully()
            return
        }
        
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.splashImageBottomImage.isActive = false
                self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction private func createAccount(_ sender: Any) {
        print("Navigate to Create Account")
        delegate?.navigateToCreateAccount()
    }
    
    @IBAction private func logIn(_ sender: Any) {
        print("Navigate to Log in")
        delegate?.navigateToLogIn()
    }
    
    func setupTermsAndPrivacyTextView() {
        let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 10
                
                let termsURL = URL(string: "https://unsplash.com/terms")!
                let privacyURL = URL(string: "https://unsplash.com/privacy")!

                let fullString = "By proceeding, you agree to our Terms & Conditions and Privacy Policy."
                let attributedString = NSMutableAttributedString(string: fullString)

                // Find the range of the substrings
                if let termsRange = fullString.range(of: "Terms & Conditions") {
                    attributedString.addAttribute(
                        .link,
                        value: termsURL,
                        range: NSRange(termsRange, in: fullString)
                    )
                }

                if let privacyRange = fullString.range(of: "Privacy Policy") {
                    attributedString.addAttribute(
                        .link,
                        value: privacyURL,
                        range: NSRange(privacyRange, in: fullString)
                    )
                }
                
                attributedString.addAttribute(
                    .paragraphStyle,
                    value: paragraphStyle,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                
        termsAndPrivacyTextView.attributedText = attributedString
        termsAndPrivacyTextView.delegate = self
        termsAndPrivacyTextView.textAlignment = .center
    }
}
