//
//  MusicFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

final class MusicFactory {
    
    // MARK: - Static Properties
    
    static var musicPlayer = MusicPlayer()
    
    // MARK: - Static Methods
    
    static func getDurationFor(track: URL) -> String {
        DateFormatters.convertFrom(time: musicPlayer.getDuration(for: track))
    }
    
    static func createTracks() -> [Track] {
        guard let track1 = StringURL.interstellar1,
              let track2 = StringURL.interstellar2,
              let track3 = StringURL.interstellar3 else { return [] }
        
        let tracks = [
            Track(
                author: AppMusic.hansZimmer,
                title: StringURL.interstellar1?.lastPathComponent ?? "...",
                icon: AppImage.stay,
                duration: getDurationFor(track: track1),
                scene: "[Murph]:\nNobody believed me, but I knew you'd come back.\n\n[Cooper]:\nHow?\n\n[Murph]:\nBecause my dad promised me"
            ),
            Track(
                author: AppMusic.hansZimmer,
                title: StringURL.interstellar2?.lastPathComponent ?? "...",
                icon: AppImage.millerPlanet,
                duration: getDurationFor(track: track2),
                scene: "[Brand]:\nHello, Rom.\n\n[Romilly]:\nI've waited years.\n\n[Cooper]:\nHow many years?\n\n[Romilly]:\nBy now it must be...\n\n[TARS]:\nIt's twenty-three years, four months, eight days."
            ),
            Track(
                author: AppMusic.hansZimmer,
                title: StringURL.interstellar3?.lastPathComponent ?? "...",
                icon: AppImage.firstStep,
                duration: getDurationFor(track: track3),
                scene: "Do not go gentle into that good night,\nOld age should burn and rave at close of day..."
            ),
        ]
        return tracks
    }
    
}
