//
//  MusicViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

final class MusicViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = MusicPlayerView()
    public var isNextButtonPressed = false
    public var tracks = MusicFactory.createTracks()
}
