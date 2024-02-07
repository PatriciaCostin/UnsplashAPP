//
//  ChangePasswordViewModelImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 31.10.2023.
//

import Foundation

final class ChangePasswordViewModelImp: ChangePasswordViewModel {
    
    private let changePasswordService: ChangePasswordService
    private let validationService: ValidationService
    
    init(
        changePasswordService: ChangePasswordService,
        validationService: ValidationService
    ) {
        self.changePasswordService = changePasswordService
        self.validationService = validationService
    }
    
    func validatePassword(password: String) -> Bool {
        return validationService.validatePassword(password: password)
    }
    
    func changePassword(
        oldPassword: String,
        newPassword: String,
        completion: @escaping (Result<Bool, ChangePasswordServiceError>) -> Void
    ) {
        
        guard validatePassword(password: oldPassword) && validatePassword(password: newPassword) else {
            return completion(.failure(.invalidFields))
        }
        
        changePasswordService.changePassword(oldPassword: oldPassword, newPassword: newPassword) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
         
            }
        }
    }
}
