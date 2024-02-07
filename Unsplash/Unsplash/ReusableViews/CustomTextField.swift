//
//  CustomTextField.swift
//  Unsplash
//
//  Created by Ion Belous on 29.09.2023.
//

import UIKit

@IBDesignable
final class CustomTextField: UIView {
    
    private struct Constants {
        static let bottomLineHeight: CGFloat = 1
        static let textFieldBottomPadding: CGFloat = 11
        static let bottomLineBottomPadding: CGFloat = 2
        static let errorLabelFontSize: CGFloat = 10
        static let textFieldFontSize: CGFloat = 14
    }
    
    private(set) var state: State = .empty {
        didSet {
            textFieldDidChangeState?()
        }
    }
    
    var validationHandler: ((String) -> (Bool, String))?
    var textFieldDidChangeState: (() -> Void)?
    
    // views
    private let textField = UITextField()
    private let bottomLine = UIView()
    private let errorLabel = UILabel()
   
    // colors
    private let mainColor = UIColor(named: "mainColor")
    private let errorColor = UIColor(named: "errorColor")
    
    // MARK: - API
    
    var text: String {
        get { textField.text ?? ""}
        set { textField.text = newValue }
    }
    
    var placeholder: String {
        get { textField.placeholder ?? "" }
        set { textField.placeholder = newValue }
    }
    
    var isSecureTextEntry = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    // MARK: - Initialization
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    private func initialSetup() {
        backgroundColor = .none

        // textfield  setup
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(
            ofSize: Constants.textFieldFontSize,
            weight: .regular
        )
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        // bottom line setup
        bottomLine.backgroundColor = mainColor

        // errorLabel setup
        errorLabel.text = " "
        errorLabel.font = .systemFont(
            ofSize: Constants.errorLabelFontSize,
            weight: .regular
        )
        errorLabel.textColor = errorColor
        errorLabel.alpha = 0
        
        // hierarchy setup
        addSubview(textField)
        addSubview(bottomLine)
        addSubview(errorLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        // textField constraints
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            topAnchor.constraint(equalTo: textField.topAnchor),
            bottomLine.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: Constants.textFieldBottomPadding)
        ])
        
        // bottomLine constraints
        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(
                equalToConstant: Constants.bottomLineHeight),
            leadingAnchor.constraint(equalTo: bottomLine.leadingAnchor),
            trailingAnchor.constraint(equalTo: bottomLine.trailingAnchor),
            errorLabel.topAnchor.constraint(
                equalTo: bottomLine.bottomAnchor,
                constant: Constants.bottomLineBottomPadding)
        ])

        // errorLabel constraints
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: errorLabel.leadingAnchor),
            trailingAnchor.constraint(equalTo: errorLabel.trailingAnchor),
            bottomAnchor.constraint(equalTo: errorLabel.bottomAnchor)
        ])
    }
    
    private func validate() {
        if let validationClosure = validationHandler {
            let (isValid, errorMessage) = validationClosure(text)
            setState(isValid ? .valid : .invalid, errorMesssage: errorMessage)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func editingDidEnd() {
        validate()
    }
    
    @objc
    private func editingChanged() {
        validate()
    }
}

// MARK: - Managing state

extension CustomTextField {
    enum State {
        case empty, valid, invalid
    }
    
    private func setState(_ state: State, errorMesssage: String = "") {
        
        self.state = state
        
        switch state {
        case .valid, .empty:
            errorLabel.alpha = 0
            textField.textColor = mainColor
            bottomLine.backgroundColor = mainColor

        case .invalid:
            errorLabel.text = errorMesssage
            errorLabel.alpha = 1
            textField.textColor = errorColor
            bottomLine.backgroundColor = errorColor
        }
    }
}
