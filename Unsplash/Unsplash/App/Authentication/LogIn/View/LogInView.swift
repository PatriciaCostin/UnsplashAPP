//
//  LogInView.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import UIKit

protocol LogInView: UIViewController {
    var viewModel: LogInViewModel { get set }
    var delegate: LogInViewDelegate? { get set }
}
