//
//  Networkable.swift
//  Unsplash
//
//  Created by Patricia Costin on 16.10.2023.
//

import Foundation

protocol Networkable {
    func fetch<T: Decodable>(
        endpointURL: URL,
        cachePolicy: NetworkableCachePolicy,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
