//
//  GalleryViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 26.12.2021.
//

import UIKit

/// Class represents viewModel for GalleryCollectionViewController
final class GalleryViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = GalleryView()
    public var marsPhotos = [Photo]()
    public var favoritesPhotos = [Favorite]()
    public var isMarsRover: Bool?
    public let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var screenWidth = UIScreen.main.bounds.width
    public var screenHeight = UIScreen.main.bounds.height
    public var isSmallDevice = UIDevice.isSmallDevice
}

