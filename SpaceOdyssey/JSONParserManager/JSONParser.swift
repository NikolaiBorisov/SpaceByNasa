//
//  JSONParser.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

/// Class parses local JSON file from main Bundle
final class JSONParser {
    
    // MARK: - Private Properties
    
    private lazy var decoder: JSONDecoder = {
        return $0
    }(JSONDecoder())
    
    // MARK: - Public Methods
    
    public func parseJSONFromFile<T: Codable>(with name: FileName, type: T.Type) -> [T]? {
        guard let data = getDataFromFile(with: name) else { return nil }
        return try? decoder.decode([T].self, from: data)
    }
    
    // MARK: - Private Methods
    
    private func getDataFromFile(with name: FileName) -> Data? {
        guard let bundlePath = Bundle.main.path(forResource: name.rawValue, ofType: FileType.json) else { return nil }
        let url = URL(fileURLWithPath: bundlePath)
        return try? Data(contentsOf: url)
    }
    
}
