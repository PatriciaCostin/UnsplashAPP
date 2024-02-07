//
//  BrowsePresentationService.swift
//  Unsplash
//
//  Created by Patricia Costin on 23.10.2023.
//

import UIKit

final class BrowsePresentationService: PresentationService {
    private let storage: PersistentStorage
    
    init(storage: PersistentStorage) {
        self.storage = storage
    }
    
    func fetchPresentationMode() -> BrowsePresentationMode {
        return storage.retrieve(type: SettingsModel.self)?.presentationMode ?? .feed
    }
    
    func updatePresentation(to mode: BrowsePresentationMode) {
        var settingsModel = storage.retrieve(type: SettingsModel.self) ?? SettingsModel()
        settingsModel.presentationMode = mode
        storage.save(settingsModel)
    }
}
