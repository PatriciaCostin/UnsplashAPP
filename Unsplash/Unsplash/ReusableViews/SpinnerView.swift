//
//  SpinnerView.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.10.2023.
//

import UIKit

final class SpinnerView: UIView {
    
    private let activityIndicator = UIActivityIndicatorView()
    private var dispatchWorkItem: DispatchWorkItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func showSpinner() {
        if let dispatchWorkItem = dispatchWorkItem {
            dispatchWorkItem.cancel()
        }
        dispatchWorkItem = DispatchWorkItem {
            self.activityIndicator.startAnimating()
            self.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: dispatchWorkItem)
    }
    
    func hideSpinner() {
        dispatchWorkItem.cancel()
            self.activityIndicator.stopAnimating()
            self.isHidden = true
    }

    func initialSetup() {
        backgroundColor = .black.withAlphaComponent(0.7)
        addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
            centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor)
        ])
    }
    
}
