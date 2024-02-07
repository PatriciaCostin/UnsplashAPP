//
//  LogInViewDelegate.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

protocol LogInViewDelegate: AnyObject {
    func navigateToForgotPassword()
    func navigateToCreateAccount()
    func userDidLogInSuccessfully()
}
