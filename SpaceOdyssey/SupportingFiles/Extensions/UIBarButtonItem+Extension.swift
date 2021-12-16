//
//  UIBarButtonItem+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 14.12.2021.
//

import UIKit

// MARK: - Create RightBarButtonItem

extension UIBarButtonItem {
    static func setupRightNavItem(
        _ target: Any,
        action: Selector,
        title: String? = nil,
        icon: UIImage? = nil
    ) -> UIBarButtonItem {
        let rightBarButtonItem = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: target,
            action: action
        )
        rightBarButtonItem.tintColor = .cyan
        rightBarButtonItem.title = title
        return rightBarButtonItem
    }
}
