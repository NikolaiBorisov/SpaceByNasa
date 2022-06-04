//
//  TrackInfoViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 28.12.2021.
//

import UIKit

/// Class provides viewModel for TrackInfoViewController
final class TrackInfoViewModel {
    
    // MARK: - Public Properties
    
    public var mainView = TrackInfoView()
    public var trackIcon = UIImage()
    public var icon = UIImage()
    public var author = String()
    public var title = String()
    public var duration = String()
    public var scene = String()
}
