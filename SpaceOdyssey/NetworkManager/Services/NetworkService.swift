//
//  NetworkService.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Protocol contains method for requesting data using urlString
protocol Networking {
    func request(urlString: String, completion: @escaping (Result<Data?, AppError>) -> Void)
}

/// Class contains methods for requesting data and creating URLSessionDataTask. Inherits Networking protocol
final class NetworkService: Networking {
    
    // MARK: - Public Methods
    
    /// Method requests data using URL
    public func request(urlString: String, completion: @escaping (Result<Data?, AppError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(AppError.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    // MARK: - Private Methods
    
    /// Method creates Data Task and returns URLSessionDataTask
    private func createDataTask(
        from request: URLRequest,
        completion: @escaping (Result<Data?, AppError>) -> Void
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                guard let data = data, !data.isEmpty else {
                    completion(.failure(AppError.somethingWrongWithUrlSessionData))
                    return
                }
                completion(.success(data))
            }
        }
    }
    
}
