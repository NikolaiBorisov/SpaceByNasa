//
//  MusicPlayer.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit
import AVFoundation

/// Class provides method for playing music
final class MusicPlayer {
    
    // MARK: - Private Properties
    
    public var player: AVAudioPlayer?
    
    // MARK: - Public Methods
    
    public func playSound(withURL: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: withURL, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Во вью контроллере есть label и в нем надо отобразить название текущего трека, как это можно сделать?
    
   // var trackLabel = player?.url?.absoluteString
    
}
