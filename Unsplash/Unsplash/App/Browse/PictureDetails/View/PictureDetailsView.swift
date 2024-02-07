//
//  PictureDetailsView.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//
import UIKit

protocol PictureDetailsView: UIViewController {
    var delegate: PictureDetailsViewDelegate? { get set }
    var viewModel: PictureDetailsViewModel { get set }
}
