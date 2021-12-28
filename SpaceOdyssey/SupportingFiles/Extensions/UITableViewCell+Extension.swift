//
//  UITableViewCell+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 28.12.2021.
//

import UIKit

// MARK: - Animate cell appearance

extension UITableViewCell {
    
    func animateCell(at indexPath: IndexPath) {
        transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(
            withDuration: 0.3,
            delay: 0.02 * Double(indexPath.row),
            animations: { [self] in
                transform = CGAffineTransform(
                    translationX: contentView.frame.width,
                    y: contentView.frame.height
                )
            })
    }
    
}
