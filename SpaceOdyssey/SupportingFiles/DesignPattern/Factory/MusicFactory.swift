//
//  MusicFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit
import AVFoundation

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

final class MusicFactory {
    
    static func duration(for resource: URL) -> Double {
        let item = AVPlayerItem(url: resource)
        let duration = Double(item.asset.duration.value) / Double(item.asset.duration.timescale)
        return duration
    }
    
    static func createTracks() -> [Music] {
        guard let track1 = StringURL.interstellar1,
              let track2 = StringURL.zemlyane else { return [] }
        let music = [
            Music(
                title: StringURL.interstellar1?.lastPathComponent ?? "...",
                icon: UIImage(named: "interstellarStay"),
                duration: DateFormatters.convertFrom(time: duration(for: track1))
            ),
            Music(
                title: StringURL.zemlyane?.lastPathComponent ?? "...",
                icon: UIImage(named: "interstellarStay"),
                duration: DateFormatters.convertFrom(time: duration(for: track2))
            ),
        ]
        return music
    }
}
