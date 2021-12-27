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
    
    private var getJSONDataService = JSONDataFetcherService()
    
    // MARK: - Public Methods
    
    public func playMusic() {
        guard let url = StringURL.mainThemeMusic else { return }
        musicPlayer.playSound(withURL: url)
    }
    
    public func getData() {
        getJSONDataService.loadCategories { [weak self] categories in
            guard let self = self else { return }
            self.categories = categories
            self.mainView.categoriesTableView.reloadData()
        }
    }
    
}
