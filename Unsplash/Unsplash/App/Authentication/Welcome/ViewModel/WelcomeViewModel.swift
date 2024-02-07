//
//  WelcomeViewModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

protocol WelcomeViewModel {
    var storage: PersistentStorage { get }
    func isUserLoggedIn() -> Bool
}
