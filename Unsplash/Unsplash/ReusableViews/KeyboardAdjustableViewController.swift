//
//  KeyboardAdjustableViewController.swift
//  Unsplash
//
//  Created by Ion Belous on 29.09.2023.
//

import UIKit

class KeyboardAdjustableViewController: UIViewController {
    
    @IBOutlet private weak var formView: UIView!
    @IBOutlet private weak var adjustableConstraint: NSLayoutConstraint!
    private var originalConstraintConstant: CGFloat = 0
    private let spaceFromKeyboard: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalConstraintConstant = adjustableConstraint.constant
        
        addKeyboardObservers()
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addKeyboardObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowSelector),
            name: UIControl.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideSelector),
            name: UIControl.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    @objc
    private func keyboardWillShowSelector(notification: Notification) {
        
        guard let keyboardBounds = (notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardTopEdge = view.frame.size.height - keyboardBounds.height
        var deltaY: CGFloat = 0
        
        let formViewBottomEdge = formView.frame.maxY + spaceFromKeyboard

        if formViewBottomEdge > keyboardTopEdge {
            deltaY = formViewBottomEdge - keyboardTopEdge
        }

        adjustableConstraint.constant -= deltaY
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHideSelector(notification: Notification) {
        
        adjustableConstraint.constant = originalConstraintConstant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
