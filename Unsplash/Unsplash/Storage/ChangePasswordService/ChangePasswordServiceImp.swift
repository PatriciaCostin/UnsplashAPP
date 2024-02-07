//
//  SettingsChangePasswordService.swift
//  Unsplash
//
//  Created by Patricia Costin on 01.11.2023.
//

final class ChangePasswordServiceImp: ChangePasswordService {
   private let storage: PersistentStorage
    
    init(storage: PersistentStorage) {
        self.storage = storage
    }
    
    func changePassword(
        oldPassword: String,
        newPassword: String,
        completion: @escaping (Result<Bool, ChangePasswordServiceError>) -> Void
    ) {
        guard var usersData = storage.retrieve(type: Users.self) else {
            return completion(.failure(.retrievingUsersError))
        }
        
        // Find the currently logged-in user.
        guard let currentlyLoggedUser = usersData.users.first(where: { user in
            return user.userToken == usersData.currentUserToken
        }) else {
            return completion(.failure(.noLoggedInUserAvailable))
        }
        
        // Filter out the user with old password from the user data.
        var updatedUsers = usersData.users.filter { $0.userToken != usersData.currentUserToken }
        
        // Check if the inteserted old password matches the current password
        guard oldPassword == currentlyLoggedUser.password  else {
            return completion(.failure(.oldPasswordDoesNotMatch))
        }
        
        // Create a new user data with an updated password.
        let updatedUserData = User(
            username: currentlyLoggedUser.username,
            password: newPassword,
            userToken: currentlyLoggedUser.userToken
        )
        
        // Append and save user data to storage.
        updatedUsers.append(updatedUserData)
        usersData.users = updatedUsers
        storage.save(usersData)
        return completion(.success(true))
    }
}
