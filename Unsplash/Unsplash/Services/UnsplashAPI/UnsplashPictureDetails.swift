//
//  UnsplashPictureDetails.swift
//  Unsplash
//
//  Created by Patricia Costin on 24.10.2023.
//

struct UnsplashPictureDetails: Codable {
    let id: String
    let publishedDate: String
    let user: User
    let exif: Exif
    let urls: [String: String]
    let location: Location
    
    struct User: Codable {
        let name: String
    }
    
    struct Exif: Codable {
        let name: String?
    }
    
    struct Location: Codable {
        let name: String?
    }
    
    enum CodingKeys: String, CodingKey, Codable {
        case id
        case publishedDate = "created_at"
        case user
        case exif
        case urls
        case location
    }
}
