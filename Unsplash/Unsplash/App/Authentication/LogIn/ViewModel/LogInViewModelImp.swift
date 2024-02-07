//
//  LogInViewModelImp.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

struct LogInViewModelImp: LogInViewModel {
    
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
    
    func logInUser(
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
        
        let user = users.users.first { $0.username == username && $0.password == password }
        
        if let user = user {
            users.currentUserToken = user.userToken
            storage.save(users)
            completion(.success(true))
            return
        }
        
        completion(.failure(.cantValidate))
    }
}
