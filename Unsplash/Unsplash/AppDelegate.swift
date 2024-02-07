//
//  AppDelegate.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        let mainColor = UIColor(named: "mainColor")
        let navbarAppearance = UINavigationBar.appearance()
        navbarAppearance.titleTextAttributes = [.foregroundColor: mainColor as Any]
        navbarAppearance.tintColor = mainColor
        
        return true
    }
}
