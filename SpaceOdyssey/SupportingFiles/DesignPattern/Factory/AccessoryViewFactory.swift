//
//  AccessoryViewFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class creates accessoryImageView for accessoryView
final class AccessoryViewFactory {
    
    static func generateAccessoryViewWith(color: UIColor) -> UIImageView {
        let image = AppImage.chevronRight
        let accessoryImage = UIImageView(frame:CGRect(
            x: 0,
            y: 0,
            width: image?.size.width ?? 20,
            height: image?.size.height ?? 20)
        )
        accessoryImage.image = image
        accessoryImage.tintColor = color
        return accessoryImage
    }
    
}

