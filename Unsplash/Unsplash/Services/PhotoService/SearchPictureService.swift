//
//  SearchPictureService.swift
//  Unsplash
//
//  Created by Patricia Costin on 16.10.2023.
//

import UIKit

protocol SearchPictureService {
    func searchPictures(
        query: String,
        page: Int,
        completion: @escaping (Result<[PictureLiteModel], Error>
        ) -> Void)
}
