//
//  PictureDetailsViewModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

protocol PictureDetailsViewModel {
    var picture: Observable<PictureModel> { get }
    var coreDataStorage: PersistentStorage { get }
    func addToLiked()
    func removeFromLiked()
    func isLiked() -> Bool
}
