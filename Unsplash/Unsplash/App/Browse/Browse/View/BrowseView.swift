//
//  BrowseView.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

protocol BrowseView: UIViewController {
    var delegate: BrowseViewDelegate? { get set }
    var viewModel: BrowseViewModel { get set }
}
