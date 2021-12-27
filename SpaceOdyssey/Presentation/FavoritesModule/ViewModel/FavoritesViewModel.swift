//
//  FavoritesViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 14.12.2021.
//

import UIKit

/// Class represents viewModel for
final class FavoritesViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = FavoritesView()
    public var favoritesPhotos: [Favorite] = []
    public let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var coreDataManager = CoreDataManagerImpl.shared
    
    // MARK: - Public Methods
    
    public func setupCallback() {
        mainView.refreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.mainView.favoritesCollectionView.reloadData()
        }
    }
    
    public func fetchDataFromCoreData() {
        favoritesPhotos = coreDataManager.fetchData(for: Favorite.self)
        mainView.favoritesCollectionView.reloadData()
    }
    
}
