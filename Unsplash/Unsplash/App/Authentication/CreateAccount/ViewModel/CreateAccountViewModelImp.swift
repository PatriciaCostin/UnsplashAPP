//
//  CreateAccountViewModelImp.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

import Foundation

struct CreateAccountViewModelImp: CreateAccountViewModel {
    
    private let storage: PersistentStorage
    private let validationService: ValidationService
    
    init(storage: PersistentStorage, validationService: ValidationService) {
        self.storage = storage
        self.validationService = validationService
    }
    
    func validateEmail(email: String) -> Bool {
        return validationService.validateEmail(email: email)
    }
    
    func validatePassword(password: String) -> Bool {
        return validationService.validatePassword(password: password)
    }
        
    func createUser(
        username: String,
        password: String,
        completion: @escaping (Result<Bool, AccountError>) -> Void
    ) {
        
        guard validateEmail(email: username) && validatePassword(password: password) else {
            return completion(.failure(.cantValidate))
        }
        
        guard var users = storage.retrieve(type: Users.self) else {
            return
        }
        
        // Check if user exists
        guard users.users.filter({ $0.username == username }).isEmpty else {
            return completion(.failure(.userTaken))
        }
        
        let newUser = User(
            username: username,
            password: password,
            userToken: UUID().uuidString
        )
        
        users.currentUserToken = newUser.userToken
        users.users.append(newUser)
        storage.save(users)
        completion(.success(true))
    }
}
