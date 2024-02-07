//
//  SettingsViewModel.swift
//  Unsplash
//
//  Created by Patricia Costin on 27.09.2023.
//

protocol SettingsViewModel {
    var storage: PersistentStorage { get }
    func logOut()
    func deletePersistenceData(completion: @escaping (Bool) -> Void)
}
