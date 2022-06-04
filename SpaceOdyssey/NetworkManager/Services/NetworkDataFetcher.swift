//
//  NetworkDataFetcher.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import Foundation

/// Protocol contains method for fetching JSONData
protocol DataFetcher {
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, AppError>) -> Void)
}

/// Class decodes and fetches JSONData. Inherits DataFetcher protocol
class NetworkDataFetcher: DataFetcher {
    
    // MARK: - Private Properties
    
    private var networking: Networking
    private var internetAvailabilityService = InternetAvailabilityService()
    
    private lazy var decoder: JSONDecoder = {
        return $0
    }(JSONDecoder())
    
    // MARK: - Initializers
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    // MARK: - Public Methods
    
    /// Method fetches JSONData
    public func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, AppError>) -> Void) {
        guard internetAvailabilityService.isInternetAvailable() else {
            completion(.failure(AppError.noInternetConnection))
            return
        }
        networking.request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                let decoded = self.decodeJSON(type: T.self, from: data, completion: completion)
                completion(.success(decoded))
            case .failure(_):
                completion(.failure(AppError.badURL))
            }
        }
    }
    
    /// Method decodes JSON file
    public func decodeJSON<T: Codable>(type: T.Type, from: Data?, completion: @escaping (Result<T?, AppError>) -> Void) -> T? {
        guard let data = from else {
            completion(.failure(AppError.noData))
            return nil
        }
        do {
            let objects = try decoder.decode(type.self, from: data)
            completion(.success(objects))
            return objects
        } catch let jsonError {
            print(AppError.badURL, jsonError)
            completion(.failure(AppError.failedParsingJSON))
            return nil
        }
    }
    
}
