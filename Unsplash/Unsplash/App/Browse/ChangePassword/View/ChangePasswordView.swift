//
//  ChangePasswordView.swift
//  Unsplash
//
//  Created by Patricia Costin on 31.10.2023.
//

import UIKit

protocol ChangePasswordView: UIViewController {
    var viewModel: ChangePasswordViewModel { get set }
    var delegate: ChangePasswordDelegate? { get set }
}
