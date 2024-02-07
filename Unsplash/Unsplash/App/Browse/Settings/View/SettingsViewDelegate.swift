//
//  SettingsViewDelegate.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//
import UIKit

protocol SettingsViewDelegate: AnyObject {
    func userWantsToLogOut()
    func openChangePassword(_ navigationController: UINavigationController)
}
