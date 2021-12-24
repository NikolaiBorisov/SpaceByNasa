//
//  UIView+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

// MARK: - CellIdentifier

/// Extension uses class name for cellIdentifier. Returns class name. Use it in Register cells
extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - RoundView

extension UIView {
    func roundViewWith(cornerRadius: CGFloat = 0, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
    }
}

// MARK: - RoundView with maskedCorners

extension UIView {
    func roundViewWith(
        cornerRadius: CGFloat = 10,
        borderColor: UIColor? = .lightGray,
        borderWidth: CGFloat = 1,
        maskedCorners: CACornerMask
    ) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.maskedCorners = maskedCorners
    }
}
