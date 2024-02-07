//
//  PictureDetailsViewModelImp.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

struct PictureDetailsViewModelImp: PictureDetailsViewModel {
    let picture: Observable<PictureModel>
    var coreDataStorage: PersistentStorage = CoreDataStorage.shared
    
    init(model: PictureModel) {
        self.picture = Observable<PictureModel>(model)
    }
    
    func addToLiked() {
        coreDataStorage.save(picture.value)
    }
    
    func removeFromLiked() {
        coreDataStorage.delete(picture.value)
    }
    
    func isLiked() -> Bool {
        
        if let pictures = coreDataStorage.retrieve(type: [PictureLiteModel].self, id: picture.value.id),
           !pictures.isEmpty {
            return true
        }
        return false
    }
}
