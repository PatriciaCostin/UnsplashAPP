//
//  PersistentStorage.swift
//  Unsplash
//
//  Created by Ion Belous on 16.10.2023.
//

protocol PersistentStorage {
    func save<T: Codable & Identifiable>(_ object: T)
    func retrieve<T: Codable>(type: T.Type) -> T?
    func retrieve<T: Codable>(type: T.Type, id: String) -> T?
    func delete<T: Codable & Identifiable>(_ object: T)
}
