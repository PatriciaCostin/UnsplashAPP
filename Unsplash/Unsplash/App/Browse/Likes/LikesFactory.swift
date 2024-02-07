//
//  LikesFactory.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

import UIKit

struct LikesFactory {
    static func create() -> LikesView {
        let viewModel = LikesViewModelImp()
        return LikesViewController(
            viewModel: viewModel
        )
    }
}
