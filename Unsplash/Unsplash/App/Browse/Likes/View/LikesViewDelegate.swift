//
//  LikesViewDelegate.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

protocol LikesViewDelegate: AnyObject {
    func openPictureDetails(_ navigationController: UINavigationController, model: PictureModel)
}
