//
//  UILabelInsets.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class adds insets for UILabel
final class UILabelInsets: UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 0,
            right: 5
        )))
    }
    
}
