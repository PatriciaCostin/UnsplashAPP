//
//  BrowseViewDelegate.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//
import UIKit

protocol BrowseViewDelegate: AnyObject {
    func openPictureDetails(_ navigationController: UINavigationController, model: PictureModel)
}
