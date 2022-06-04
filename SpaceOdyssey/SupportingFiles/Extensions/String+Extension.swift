//
//  String+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

// MARK: - Localization

/// Use this extension for localization
extension String {
    static var errorNotLocalized: String {
        return "error_not_localized"
    }
    
    func localized() -> String {
        let result = NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: .errorNotLocalized,
            comment: ""
        )
        if result == .errorNotLocalized {
            debugPrint("Error: String '\(self)' is not localized")
            return .errorNotLocalized
        }
        return result
    }
}
