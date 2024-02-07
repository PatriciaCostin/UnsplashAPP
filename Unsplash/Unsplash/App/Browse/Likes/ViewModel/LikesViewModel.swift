//
//  LikesViewModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

protocol LikesViewModel {
    var pictures: Observable<[PictureModel]> { get }
    var coreDataStorage: PersistentStorage { get }
    func fetchPictures()
}
