//
//  BrowseViewFactory.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

struct BrowseViewFactory {
    
    static func create() -> BrowseView {
        let persistentStorage = DefaultService()
        let unsplashPictureService = UnsplashPictureService()
        let fetchPicturesDetailsService = UnsplashFetchPictureDetailsService()
        let browsePresentationService = BrowsePresentationService(storage: persistentStorage)
        let viewModel = BrowseViewModelImp(
            searchPictureService: unsplashPictureService,
            presentationService: browsePresentationService,
            fetchPicturesDetailsService: fetchPicturesDetailsService
        )
        return BrowseViewController(
            viewModel: viewModel
        )
    }
}
