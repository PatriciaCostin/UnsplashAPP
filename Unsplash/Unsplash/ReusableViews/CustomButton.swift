//
//  File.swift
//  Unsplash
//
//  Created by Patricia Costin on 02.10.2023.
//

import UIKit
import Foundation

@IBDesignable
final class CustomButton: UIButton {
    private let highlightedBackgroundColor = UIColor(named: "buttonHighlightedBackground")
    private let defaultBackgroundColor = UIColor(named: "buttonDefaultBackground")
    private let defaultTitleColor = UIColor(named: "buttonDefaultTitle")
    private let disabledTitleColor = UIColor(named: "buttonDisableTitle")
    private let cornerRadius: CGFloat = 8
    private let titleFontSize: CGFloat = 16
    private let defaultHeight: CGFloat = 48
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateButtonAppearance()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: defaultHeight)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateButtonAppearance()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateButtonAppearance()
    }

    func updateButtonAppearance() {
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = defaultBackgroundColor
        self.setTitleColor(isEnabled ? defaultTitleColor : disabledTitleColor, for: .normal)
        let font = isEnabled ? UIFont.boldSystemFont(ofSize: titleFontSize) : UIFont.systemFont(ofSize: titleFontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedTitle = NSAttributedString(string: self.currentTitle ?? "", attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
