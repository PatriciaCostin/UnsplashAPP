//
//  FetchPicturesDetailsService.swift
//  Unsplash
//
//  Created by Patricia Costin on 24.10.2023.
//

protocol FetchPicturesDetailsService {
    func fetchPictureDetails(
        pictureID: String,
        completion: @escaping (Result<PictureModel, Error>) -> Void
    )
}
