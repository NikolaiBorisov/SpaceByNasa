//
//  MusicViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

/// Class provides viewModel for MusicPlayerViewController
final class MusicViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = MusicPlayerView()
    public var nextButtonCount = 0
    public var tracks = MusicFactory.createTracks()
    public var isFirstLoaded = true
}
