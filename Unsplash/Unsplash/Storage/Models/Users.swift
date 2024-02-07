//
//  Users.swift
//  Unsplash
//
//  Created by Ion Belous on 16.10.2023.
//

struct Users: Codable, Identifiable {
    static var databaseID = "users_database"
    
    var id: String { Self.databaseID }
    var users: [User]
    var currentUserToken: String?
}
