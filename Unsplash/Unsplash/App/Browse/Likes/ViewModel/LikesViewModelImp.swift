//
//  LikesViewModelImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

struct LikesViewModelImp: LikesViewModel {
    var pictures: Observable<[PictureModel]>
    var coreDataStorage: PersistentStorage = CoreDataStorage.shared
    
    init() {
        self.pictures = Observable([])
    }
    
    func fetchPictures() {
        let pictures = coreDataStorage.retrieve(type: [PictureModel].self)
        self.pictures.value = pictures ?? [PictureModel]()
    }
}
