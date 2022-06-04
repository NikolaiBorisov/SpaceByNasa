//
//  UIScrollView+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 26.12.2021.
//

import UIKit

extension UIScrollView {
    
    func isViewScrollIndicator(view: UIView) -> Bool {
        let className = NSStringFromClass(type(of: view))
        if className == "_UIScrollViewScrollIndicator" || className == "UIImageView" {
            return true
        }
        return false
    }
    
    var scrollIndicators: (horizontal: UIView?, vertical: UIView?) {
        guard self.subviews.count >= 2 else { return (nil, nil) }
        
        let horizontalIndicatorPosition = self.subviews.count - 2
        let verticalIndicatorPosition = self.subviews.count - 1
        
        var horizontalIndicator: UIView?
        var verticalIndicator: UIView?
        
        let viewForHorizontalIndicator = self.subviews[horizontalIndicatorPosition]
        if isViewScrollIndicator(view: viewForHorizontalIndicator) {
            horizontalIndicator = viewForHorizontalIndicator.subviews[0]
        }
        
        let viewForVerticalIndicator = self.subviews[verticalIndicatorPosition]
        if isViewScrollIndicator(view: viewForVerticalIndicator) {
            verticalIndicator = viewForVerticalIndicator.subviews[0]
        }
        return (horizontal: horizontalIndicator, vertical: verticalIndicator)
    }
    
}
