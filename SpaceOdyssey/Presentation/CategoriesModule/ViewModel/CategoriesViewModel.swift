//
//  CategoriesViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class provides viewModel for CategoriesViewController
final class CategoriesViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = CategoriesView()
    public var isRuLocale: Bool { Locale.current.languageCode == "ru" }
    public var categories: [Category] = []
    public var musicPlayer = MusicPlayer()
    
    // MARK: - Private Properties
    
    private var dataFetcherService = DataFetcherService()
    
    // MARK: - Public Methods
    
    public func playMusic() {
        guard let url = StringURL.interstellar1 else { return }
        musicPlayer.playSound(withURL: url)
    }
    
    public func getData() {
        dataFetcherService.fetchLocalCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.categories = data ?? []
                self.mainView.categoriesTableView.reloadData()
            }
        }
    }
    
}
