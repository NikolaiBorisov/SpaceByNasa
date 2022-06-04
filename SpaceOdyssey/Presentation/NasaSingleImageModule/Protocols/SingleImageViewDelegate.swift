//
//  SingleImageViewDelegate.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Protocol contains method for longPressGestureRecognizer in  SingleImageView
protocol SingleImageViewDelegate: AnyObject {
    func longPressGestureTapped()
}
