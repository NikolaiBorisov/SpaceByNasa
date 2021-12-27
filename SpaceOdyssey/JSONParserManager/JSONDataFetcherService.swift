//
//  JSONDataFetcherService.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

final class JSONDataFetcherService {
    
    // MARK: - Private Properties
    
    private var jsonParser = JSONParser()
    
    // MARK: - Public Methods
    
    public func loadCategories(completion: @escaping (([Category]) -> Void)) {
        let categories = loadDataFrom(file: .categoriesJSON, type: Category.self)
        completion(categories)
    }
    
    // MARK: - Private Methods
    
    private func loadDataFrom<T: Codable>(file: FileName, type: T.Type) -> [T] {
        guard let data = jsonParser.parseJSONFromFile(with: file, type: T.self) else { return [] }
        return data
    }
    
}
