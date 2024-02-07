//
//  UnsplashPictureService.swift
//  Unsplash
//
//  Created by Patricia Costin on 16.10.2023.
//

import UIKit

final class UnsplashPictureService: SearchPictureService {
    
    private let unsplashAPI = UnsplashAPI(networkManager: NetworkManager())
    
    func searchPictures(
        query: String,
        page: Int,
        completion: @escaping (Result<[PictureLiteModel], Error>) -> Void) {
            unsplashAPI.searchPicturesBy(query: query, page: page) { result in
                var pictureModels: [PictureLiteModel] = []
                
                switch result {
                case .success(let rootObject):
                    pictureModels = rootObject.results.map { item in
                        return PictureLiteModel(
                            imageID: item.id,
                            imageURL: item.urls["small"] ?? ""
                        )
                    }
                    if pictureModels.isEmpty {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    completion(.success(pictureModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
