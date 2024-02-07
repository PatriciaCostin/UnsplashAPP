//
//  StorageService.swift
//  Unsplash
//
//  Created by Patricia Costin on 23.10.2023.
//
import UIKit

final class DefaultService: PersistentStorage {
    typealias Object = Codable & Identifiable
    private let defaults: UserDefaults = {
        let defaults = UserDefaults(suiteName: "Internship.Mentors.Unsplash")
        return defaults ?? .standard
    }()
    
    func save<T>(_ object: T) where T: Object {
        
        guard let encodedObject = try? JSONEncoder().encode(object) else {
            return
        }
        defaults.set(encodedObject, forKey: "internship.unsplash.settings")
    }
    
    func retrieve<T>(type: T.Type) -> T? where T: Codable {
        
        guard let storedObjects = defaults.data(forKey: "internship.unsplash.settings") else {
            return nil
        }
        
        return try? JSONDecoder().decode(type, from: storedObjects)
    }

    func retrieve<T>(type: T.Type, id: String) -> T? where T: Codable {
        // Not used in the current implementation of the class.
        return nil
    }
    
    func delete<T>(_ object: T) where T: Object {
        defaults.removeObject(forKey: "internship.unsplash.settings")
    }
}
