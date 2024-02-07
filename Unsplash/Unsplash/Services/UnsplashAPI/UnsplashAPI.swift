//
//  UnsplashAPI.swift
//  Unsplash
//
//  Created by Patricia Costin on 16.10.2023.
//

import Foundation

final class UnsplashAPI {
    
    private let networkManager: Networkable
    private let imagesPerPage = "10"
    
    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func searchPicturesBy(
        query: String,
        page: Int,
        completion: @escaping (Result<UnsplashSearchResults, NetworkError>) -> Void) {
            
            guard let endpointUrl = UnsplashEndpoint.searchPhotos(query: query, page: page).endpointURL else {
                completion(.failure(.badURL))
                return
            }
            
            networkManager.fetch(
                endpointURL: endpointUrl,
                cachePolicy: .returnCacheDataElseLoad
            ) { (result: Result<UnsplashSearchResults, NetworkError>) in
                
                switch result {
                case .success(let result): completion(.success(result))
                case .failure(let error): completion(.failure(error))
                }
            }
        }
    
    func fetchPictureDetailsBy(
        pictureId: String,
        completion: @escaping (Result<UnsplashPictureDetails, NetworkError>) -> Void
    ) {
        guard let endpointUrl = UnsplashEndpoint.fetchPictureDetails(pictureId: pictureId).endpointURL else {
            completion(.failure(.badURL))
            return
        }
        
        networkManager.fetch(
            endpointURL: endpointUrl,
            cachePolicy: .returnCacheDataElseLoad
        ) { (result: Result<UnsplashPictureDetails, NetworkError>) in
            
            switch result {
            case .success(let result): completion(.success(result))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
