//
//  Network Manager.swift
//  Unsplash
//
//  Created by Patricia Costin on 16.10.2023.
//

import Foundation

/// `NetworkManager` is responsible for executing network requests and handling responses.
/// It provides a generic method to fetch data from a given URL and decode it into a desired type.
final class NetworkManager: Networkable {
    
    /// Fetches and decodes data from a given URL.
    /// - Parameters:
    ///   - endpointURL: The URL to fetch data from.
    ///   - cachePolicy: Determines the caching behaviour. By default, it will
    ///   return cached data if available, otherwise fetch from the network.
    ///   - completion: A closure to be executed once the fetch is completed. It returns a `Result`
    ///   containing either the decoded data or a `NetworkError`.
    func fetch<T: Decodable>(
        endpointURL: URL,
        cachePolicy: NetworkableCachePolicy = .returnCacheDataElseLoad,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var urlRequest = URLRequest(url: endpointURL)
        
        switch cachePolicy {
        case .returnCacheDataElseLoad:
            urlRequest.cachePolicy = .returnCacheDataElseLoad
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                // Handle server-side error.
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let data = data else {
                // Handle case when there's no data in the response.
                completion(.failure(.noData))
                return
            }
            
            do {
                // Try decoding the response data into the expected type.
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                // Handle decoding errors.
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
