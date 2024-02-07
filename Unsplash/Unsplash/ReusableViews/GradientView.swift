//
//  GradientView.swift
//  Unsplash
//
//  Created by Ion Belous on 29.09.2023.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
    
    var topColor: UIColor = .clear {
        didSet {
            applyGradient()
        }
    }
    
    var bottomColor: UIColor = .clear {
        didSet {
            applyGradient()
        }
    }
    
    var locations: [NSNumber] = [0.0, 0.5] {
        didSet {
            applyGradient()
        }
    }
    
    private var gradientLayer: CAGradientLayer {
        return layer as? CAGradientLayer ?? CAGradientLayer()
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private func applyGradient() {
        backgroundColor = .none
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    override func prepareForInterfaceBuilder() {
        applyGradient()
    }
}
