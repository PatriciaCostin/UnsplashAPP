//
//  CreateAccountView.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import UIKit

protocol CreateAccountView: UIViewController {
    var viewModel: CreateAccountViewModel { get set }
    var delegate: CreateAccountViewDelegate? { get set }
}
