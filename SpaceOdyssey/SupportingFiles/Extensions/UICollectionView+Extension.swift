//
//  UICollectionView+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

// MARK: - Register and DequeueCell methods for UICollectionViewCell

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

// MARK: - BackgroundImage

extension UICollectionView {
    func setBackgroundWith(image: UIImage) {
        let bgImage = UIImageView()
        bgImage.image = image
        bgImage.contentMode = .scaleToFill
        self.backgroundView = bgImage
    }
}
