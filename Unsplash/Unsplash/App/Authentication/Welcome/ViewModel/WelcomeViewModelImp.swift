//
//  WelcomeViewModelImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 25.09.2023.
//

struct WelcomeViewModelImp: WelcomeViewModel {
    var storage: PersistentStorage = SecureStorage()
    
    func isUserLoggedIn() -> Bool {
        guard let users = storage.retrieve(type: Users.self),
                  users.currentUserToken != nil else {
            return false
        }
        
        return true
    }
}
