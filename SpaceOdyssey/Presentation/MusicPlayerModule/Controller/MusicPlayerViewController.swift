//
//  MusicPlayerViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import UIKit
import MediaPlayer

protocol MusicPlayerViewControllerDelegate: AnyObject {
    func stop()
    func nextTrack(isNextButtonTapped: Bool)
    func play()
    func pause()
}

/// Class displays the music player
final class MusicPlayerViewController: UIViewController {
    
    weak var delegate: MusicPlayerViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private lazy var mainView = MusicPlayerView()
    private var isNextButtonPressed = false
    private var musicPlayer = MusicPlayer()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCallbacks()
        setupNavBar()
        mainView.configureNowIsPlayingLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.showView(view: [mainView.nowIsPlayingLabel, mainView.playerContainerView])
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        setupNavBarWith(
            title: "Sci-Fi Music",
            font: .avenirNextDemiBoldOfSize(35)
        )
    }
    
    private func setupCallbacks() {
        mainView.playButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.play()
        }
        
        mainView.pauseButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.pause()
        }
        
        mainView.stopButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.stop()
        }
        
        mainView.nextButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.isNextButtonPressed.toggle()
            if self.isNextButtonPressed {
                self.delegate?.nextTrack(isNextButtonTapped: self.isNextButtonPressed)
                self.mainView.nowIsPlayingLabel.text = StringURL.zemlyane?.lastPathComponent
            } else if !self.isNextButtonPressed {
                self.delegate?.nextTrack(isNextButtonTapped: self.isNextButtonPressed)
                self.mainView.nowIsPlayingLabel.text = StringURL.mainThemeMusic?.lastPathComponent
            }
        }
    }
    
}
