//
//  ForgotPasswordView.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import UIKit

protocol ForgotPasswordView: UIViewController {
    var viewModel: ForgotPasswordViewModel { get set }
    var delegate: ForgotPasswordViewDelegate? { get set }
}
