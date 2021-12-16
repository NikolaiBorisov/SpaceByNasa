//
//  UIFont+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

extension UIFont {
    
    static var avenirNextMediumOfSize = { (size: CGFloat) in
        UIFont(name: "Avenir Next Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var avenirNextDemiBoldOfSize = { (size: CGFloat) in
        UIFont(name: "Avenir Next Demi Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
