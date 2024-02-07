//
//  UnsplashPictureDetailsAdapter.swift
//  Unsplash
//
//  Created by Patricia Costin on 24.10.2023.
//

import Foundation

final class UnsplashPictureDetailsAdapter {
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    func convertToPictureModel(_ item: UnsplashPictureDetails) -> PictureModel {
        let date = item.publishedDate
        let formattedDate = dateFormatter.date(from: date)
        
        return PictureModel(
            id: item.id,
            imageUrl: item.urls["regular"] ?? "",
            author: item.user.name,
            location: item.location.name ?? "Unknown location",
            publicationDate: formattedDate ?? Date(),
            device: item.exif.name ?? "Unknown device",
            licence: "Unsplash Licence"
        )
    }
}
