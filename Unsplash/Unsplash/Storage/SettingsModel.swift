//
//  SettingsModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 24.10.2023.
//

import UIKit

struct SettingsModel: Codable, Identifiable {
    var id = UUID().uuidString
    var presentationMode: BrowsePresentationMode = .feed
}
