//
//  FooterView.swift
//  Unsplash
//
//  Created by Ion Belous on 28.10.2023.
//

import UIKit

final class FooterView: UICollectionReusableView {
    
    let refreshControl = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
        addSubview(refreshControl)
        
        refreshControl.isHidden = true
        refreshControl.color = .lightGray
        refreshControl.style = .medium
        
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: refreshControl.centerXAnchor),
            centerYAnchor.constraint(equalTo: refreshControl.centerYAnchor)
        ])
    }
    
    func showSpinner(_ show: Bool) {
        if show {
            refreshControl.startAnimating()
            refreshControl.isHidden = false
        } else {
            refreshControl.stopAnimating()
            refreshControl.isHidden = true
        }
    }
}
