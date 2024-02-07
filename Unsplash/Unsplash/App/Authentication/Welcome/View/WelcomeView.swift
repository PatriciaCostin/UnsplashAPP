//
//  WelcomeView.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

import UIKit

protocol WelcomeView: UIViewController {
    var viewModel: WelcomeViewModel { get set }
    var delegate: WelcomeViewDelegate? { get set }
}
