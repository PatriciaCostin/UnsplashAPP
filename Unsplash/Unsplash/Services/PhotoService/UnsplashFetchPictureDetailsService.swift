//
//  UnsplashFetchPictureDetailsService.swift
//  Unsplash
//
//  Created by Patricia Costin on 24.10.2023.
//
import Foundation

final class UnsplashFetchPictureDetailsService: FetchPicturesDetailsService {

    private let unsplashAPI = UnsplashAPI(networkManager: NetworkManager())
    private let adapter = UnsplashPictureDetailsAdapter()
    
    func fetchPictureDetails(
        pictureID: String,
        completion: @escaping (Result<PictureModel, Error>) -> Void
    ) {
            unsplashAPI.fetchPictureDetailsBy(pictureId: pictureID) { result in
                switch result {
                case .success(let rootObject):
                    let pictureModel = self.adapter.convertToPictureModel(rootObject)
                    completion(.success(pictureModel))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
