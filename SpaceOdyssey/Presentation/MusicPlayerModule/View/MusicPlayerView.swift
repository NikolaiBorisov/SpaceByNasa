//
//  MusicPlayerView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import UIKit

/// Class contains UIElements for MusicPlayerViewController
final class MusicPlayerView: UIView {
    
    // MARK: - Public Properties
    
    public var playButtonWasTapped: (() -> Void)?
    public var pauseButtonWasTapped: (() -> Void)?
    public var stopButtonWasTapped: (() -> Void)?
    public var nextButtonWasTapped: (() -> Void)?
    
    public let nowIsPlayingLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.alpha = 0
        return $0
    }(UILabel())
    
    public lazy var playerContainerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alpha = 0
        return $0
    }(UIView())
    
    // MARK: - Private Properties
    
    private var screenWidth = UIScreen.main.bounds.width
    
    private lazy var playButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var pauseButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var stopButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "stop.circle"), for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var nextButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "forward.circle"), for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var buttonStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [playButton, pauseButton, stopButton, nextButton]))
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func onButtonTapped(sender: UIButton) {
        switch sender {
        case playButton:
            playButtonWasTapped?()
        case pauseButton:
            pauseButtonWasTapped?()
        case stopButton:
            stopButtonWasTapped?()
        case nextButton:
            nextButtonWasTapped?()
        default: return
        }
    }
    
    // MARK: - Public Methods
    
    public func configureNowIsPlayingLabel() {
        nowIsPlayingLabel.text = StringURL.mainThemeMusic?.lastPathComponent
    }
    
    /// Animate UIView
    public func showView(view: [UIView]) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseInOut
        ) {
            view[0].alpha = 1
            view[1].alpha = 1
        }
    }
    
    // MARK: - Private Methods
    
    private func setupButtonAction() {
        [playButton, pauseButton, stopButton, nextButton].forEach {
            $0.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setupView() {
        backgroundColor = .black
        playerContainerView.backgroundColor = .black
        playerContainerView.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
        nowIsPlayingLabel.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(nowIsPlayingLabel)
        addSubview(playerContainerView)
        playerContainerView.addSubview(buttonStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nowIsPlayingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nowIsPlayingLabel.bottomAnchor.constraint(equalTo: playerContainerView.topAnchor, constant: -10),
            nowIsPlayingLabel.heightAnchor.constraint(equalToConstant: 30),
            nowIsPlayingLabel.widthAnchor.constraint(equalToConstant: screenWidth / 1.5),
            
            playerContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playerContainerView.heightAnchor.constraint(equalToConstant: 100),
            playerContainerView.widthAnchor.constraint(equalToConstant: screenWidth / 1.5),
            
            buttonStackView.topAnchor.constraint(equalTo: playerContainerView.topAnchor, constant: 10),
            buttonStackView.bottomAnchor.constraint(equalTo: playerContainerView.bottomAnchor, constant: -10),
            buttonStackView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor, constant: -10)
        ])
    }
    
}
