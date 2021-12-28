//
//  DateFormatters.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 28.12.2021.
//

import UIKit

/// Converts time to String for audio track duration
enum DateFormatters {
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter
    }
    
    static func convertFrom(time: Double) -> String {
        let time = Date(timeIntervalSince1970: TimeInterval(time))
        return Self.dateFormatter.string(from: time)
    }
    
}
