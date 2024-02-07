//
//  SettingsView.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

protocol SettingsView: UIViewController {
    var viewModel: SettingsViewModel { get set }
    var delegate: SettingsViewDelegate? { get set }
}
