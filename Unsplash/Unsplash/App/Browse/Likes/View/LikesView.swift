//
//  LikesView.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

protocol LikesView: UIViewController {
    var viewModel: LikesViewModel { get set }
    var delegate: LikesViewDelegate? { get set }
}
