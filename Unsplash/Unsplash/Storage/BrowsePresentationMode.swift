//
//  BrowsePresentationMode.swift
//  Unsplash
//
//  Created by Patricia Costin on 24.10.2023.
//

enum BrowsePresentationMode: Codable {
    case feed
    case grid
    
    var imageName: String {
        switch self {
        case .feed:
            return "square"
        case .grid:
            return "square.grid.2x2"
        }
    }
    
    var filledImageName: String {
        switch self {
        case .feed:
            return "square.fill"
        case .grid:
            return "square.grid.2x2.fill"
        }
    }
}
