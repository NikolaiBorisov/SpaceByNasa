//
//  Double+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 24.12.2021.
//

import UIKit

// MARK: - Remove extra numbers after a comma

extension Double {
    
    func reduceNumbers() -> String {
        String(format: "%.2f", self)
    }
    
}
