//
//  NetworkErrors.swift
//  Unsplash
//
//  Created by Patricia Costin on 17.10.2023.
//

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError(Error)
    case serverError(Error)
    case unknown(Error?)
}
