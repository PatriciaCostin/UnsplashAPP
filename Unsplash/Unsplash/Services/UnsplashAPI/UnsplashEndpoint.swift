//
//  UnsplashEndpoint.swift
//  Unsplash
//
//  Created by Patricia Costin on 18.10.2023.
//

import UIKit

enum UnsplashEndpoint {
    
    case searchPhotos(query: String, page: Int)
    case fetchPictureDetails(pictureId: String)
    
    var endpointURL: URL? {
        switch self {
        case .searchPhotos(let query, let page):
            let baseURL = UnsplashConfig.baseURL
            let accessKey = UnsplashConfig.accessKey
            let urlString = "\(baseURL)/search/photos?page=\(page)&query=\(query)&client_id=\(accessKey)&orientation=portrait"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return URL(string: urlString)
            
        case .fetchPictureDetails(let pictureId):
            let baseURL = UnsplashConfig.baseURL
            let accessKey = UnsplashConfig.accessKey
            let urlString = "\(baseURL)/photos/\(pictureId)?client_id=\(accessKey)&orientation=portrait"
            return URL(string: urlString)
        }
    }
}
    
