//
//  SettingsFactory.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

struct SettingsFactory {
    static func create() -> SettingsView {
        let viewModel = SettingsViewModelImp()
        return SettingsViewController(
            viewModel: viewModel
        )
    }
}
