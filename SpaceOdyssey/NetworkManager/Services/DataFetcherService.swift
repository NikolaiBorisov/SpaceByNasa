//
//  DataFetcherService.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class fetches data from DTOModel
final class DataFetcherService {
    
    // MARK: - Private Properties
    
    private var dataFetcher: DataFetcher
    
    // MARK: - Initializers
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    // MARK: - Public Methods
    
    /// Method fetches APODData using URL
    public func fetchAPODData(completion: @escaping (Result<ApodDTO?, AppError>) -> Void) {
        let urlString = StringURL.apodURL
        dataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    /// Method fetches EPICData using URL
    public func fetchEPICData(completion: @escaping (Result<[EpicDTO]?, AppError>) -> Void) {
        let urlString = StringURL.epicURL
        dataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    /// Method fetches AsteroidData using URL
    public func fetchAsteroidData(completion: @escaping (Result<AsteroidDTO?, AppError>) -> Void) {
        let urlString = StringURL.asteroidURL
        dataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    /// Method fetches MarsRover photos
    public func fetchMarsRoverPhotos(completion: @escaping (Result<MarsRoverDTO?, AppError>) -> Void) {
        let urlString = StringURL.marsRoverURL
        dataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
}
