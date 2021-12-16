//
//  MarsRoverViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class represents viewModel for MarsRoverCollectionViewController
final class MarsRoverViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = MarsRoverView()
    public var navBarTitle = ""
    public var dataFetcherService =  DataFetcherService()
    public var marsRoverPhotos: MarsRoverDTO?
    public let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    // MARK: - Public Methods
    
    public func getMarsRoverPhotos(completion: @escaping (AppError) -> Void?) {
        mainView.activityIndicator.startAnimating()
        dataFetcherService.fetchMarsRoverPhotos { [weak self] result in
            switch result {
            case .failure(let error):
                completion(error)
                print(error)
            case .success(let photos):
                guard let self = self else { return }
                self.marsRoverPhotos = photos
                self.mainView.marsRoverCollectionView.reloadData()
                self.mainView.activityIndicator.stopAnimating()
                self.mainView.collectionViewRefreshControl.endRefreshing()
            }
        }
    }
    
    public func setupCallback(completion: @escaping (AppError) -> Void?) {
        mainView.refreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.getMarsRoverPhotos(completion: completion)
        }
    }
    
}
