//
//  LocalDataFetcher.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import Foundation

/// Class decodes and fetches local JSONData
final class LocalDataFetcher: NetworkDataFetcher {
    
    override func fetchJSONData<T>(
        urlString: String,
        completion: @escaping (Result<T?, AppError>) -> Void
    ) where T : Decodable, T : Encodable {
        guard let file = Bundle.main.path(forResource: urlString, ofType: FileType.json) else {
            print("Could't find \(urlString) in main bundle.")
            completion(.failure(.noLocalFile))
            return
        }
        let url = URL(fileURLWithPath: file)
        let data = try? Data(contentsOf: url)
        let decoded = self.decodeJSON(type: T.self, from: data, completion: completion)
        completion(.success(decoded))
    }
    
}
