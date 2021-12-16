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
    public let categories = NasaCategoryFactory.makeCategories()
    public var musicPlayer = MusicPlayer()
    
    // MARK: - Public Methods
    
    public func playMusic() {
        guard let url = StringURL.mainThemeMusic else { return }
        musicPlayer.playSound(withURL: url)
    }
    
}
