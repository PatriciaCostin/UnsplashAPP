//
//  PresentationService.swift
//  Unsplash
//
//  Created by Patricia Costin on 23.10.2023.
//

protocol PresentationService {

    func fetchPresentationMode() -> BrowsePresentationMode
    func updatePresentation(to mode: BrowsePresentationMode)
}
