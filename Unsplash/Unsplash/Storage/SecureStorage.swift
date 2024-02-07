//
//  SecureStorage.swift
//  Unsplash
//
//  Created by Ion Belous on 16.10.2023.
//

import UIKit
import KeychainSwift

final class SecureStorage: PersistentStorage {
    typealias Object = Codable & Identifiable
    
    private let keychain = KeychainSwift()
    
    func save<T>(_ object: T) where T: Object {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }
        
        keychain.set(data, forKey: Users.databaseID)
    }
    
    func retrieve<T>(type: T.Type) -> T? where T?: Codable {
        guard let data = keychain.getData(Users.databaseID) else {
            return Users(users: [], currentUserToken: nil) as? T
        }
        
        return try? JSONDecoder().decode(type, from: data)
    }
    
    func retrieve<T>(type: T.Type, id: String) -> T? where T?: Codable {
        guard let data = keychain.getData(Users.databaseID) else {
            return nil
        }
        
        guard let users = (try? JSONDecoder().decode(type, from: data)) as? Users else {
            return nil
        }
        
        return users.users.first { $0.username == id } as? T
    }

    func delete<T>(_ object: T) where T: Object {
        keychain.delete(Users.databaseID)
    }
}
