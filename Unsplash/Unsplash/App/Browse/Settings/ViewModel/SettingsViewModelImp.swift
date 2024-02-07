//
//  SettingsViewModelImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import Foundation

struct SettingsViewModelImp: SettingsViewModel {
    var storage: PersistentStorage = SecureStorage()
    var coreDataStorage: PersistentStorage = CoreDataStorage.shared
    
    func logOut() {
        if var users = storage.retrieve(type: Users.self) {
            users.currentUserToken = nil
            storage.save(users)
        }
    }
    
    func deletePersistenceData(completion: @escaping (Bool) -> Void) {
        let foundObjects = coreDataStorage.retrieve(type: [PictureModel].self)
        
        guard let foundObjects = foundObjects, !foundObjects.isEmpty else {
            return completion(false)
        }
        
        foundObjects.forEach { coreDataStorage.delete($0) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(true)
        }
    }
}
