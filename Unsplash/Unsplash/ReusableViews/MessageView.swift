//
//  MessageView.swift
//  Unsplash
//
//  Created by Ion Belous on 25.10.2023.
//

import UIKit

final class MessageView: UIView {
    
    // MARK: - Constants
    private struct Constants {
        static let iconDimension: CGFloat = 60
        static let stackSpacing: CGFloat = 16
        static let sidePadding: CGFloat = 16
        static let labelFontSize: CGFloat = 16
        static let tintColor: UIColor = .lightGray
    }
    
    // MARK: - UI Components
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.tintColor
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        label.textColor = Constants.tintColor
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, messageLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers
    init(message: String, sfSymbolName: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        if let image = UIImage(systemName: sfSymbolName) {
            iconImageView.image = image
        } else {
            print("Warning: The SF Symbol name provided does not exist.")
        }
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Constants.sidePadding),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constants.sidePadding),
            stackView.widthAnchor.constraint(equalToConstant: Constants.iconDimension * 2),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconDimension),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconDimension)
        ])
    }
    
    // MARK: - Public Methods
    func addToSuperViewAndCenter(_ superView: UIView) {
        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            self.leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: Constants.sidePadding),
            self.trailingAnchor.constraint(lessThanOrEqualTo: superView.trailingAnchor, constant: -Constants.sidePadding)
        ])
    }
}
