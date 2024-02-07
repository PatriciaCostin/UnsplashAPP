//
//  ForgotPasswordViewModelImp.swift
//  Unsplash
//
//  Created by Ion Belous on 27.09.2023.
//

struct ForgotPasswordViewModelImp: ForgotPasswordViewModel {
    
    private let storage: PersistentStorage
    private let validationService: ValidationService
    
    init(storage: PersistentStorage, validationService: ValidationService) {
        self.storage = storage
        self.validationService = validationService
    }
    
    func validateEmail(email: String) -> Bool {
        return validationService.validateEmail(email: email)
    }
    
    func resetPassword(
        for username: String,
        completion: @escaping (Result<String, AccountError>) -> Void
    ) {
        
        guard validateEmail(email: username) else {
            return completion(.failure(.cantValidate))
        }
        
        guard var users = storage.retrieve(type: Users.self) else {
            return
        }
        
        guard let oldUser = users.users.first(where: { $0.username == username }) else {
            return completion(.failure(.cantValidate))
        }
        
        let newPassword = generatePassword()
        let newUser = User(
            username: oldUser.username,
            password: newPassword,
            userToken: oldUser.userToken
        )
        users.users.removeAll { $0.username == oldUser.username }
        users.users.append(newUser)
        storage.save(users)
        
        return completion(.success(newUser.password))
    }
    
    private func generatePassword() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        let specialChars = "_#!?."
        
        var result = String((0..<4).map { _ in letters.randomElement()! })
        result += String((0..<2).map { _ in numbers.randomElement()! })
        result += String((0..<1).map { _ in specialChars.randomElement()! })
        
        return String(result.shuffled())
    }
}
