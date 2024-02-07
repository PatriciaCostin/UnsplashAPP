//
//  WelcomeViewDelegate.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func navigateToCreateAccount()
    func navigateToLogIn()
    func userDidLogInSuccessfully()
}
