//
//  RefreshControlFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class creates refreshControl for UITableView and UICollectionView
final class RefreshControlFactory {
    
    static func generate(with color: UIColor? = .cyan) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = color
        return refreshControl
    }
    
}
