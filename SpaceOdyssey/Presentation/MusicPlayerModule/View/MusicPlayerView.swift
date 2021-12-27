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
    
    public var cellHeight: CGFloat = 80
    
    public lazy var musicTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: MusicPlayerCell.self)
        $0.backgroundColor = .black
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        return $0
    }(UITableView())
    
    public let nowIsPlayingLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.alpha = 0
        $0.font = .avenirNextMediumOfSize(18)
        return $0
    }(UILabel())
    
    public lazy var buttonStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
        $0.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.alpha = 0
        return $0
    }(UIStackView(arrangedSubviews: [playButton, pauseButton, stopButton, nextButton]))
    
    // MARK: - Private Properties
    
    private var screenWidth = UIScreen.main.bounds.width
    
    private lazy var playButton: UIButton = {
        $0.setBackgroundImage(AppImage.play, for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var pauseButton: UIButton = {
        $0.setBackgroundImage(AppImage.pause, for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var stopButton: UIButton = {
        $0.setBackgroundImage(AppImage.stop, for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var nextButton: UIButton = {
        $0.setBackgroundImage(AppImage.next, for: .normal)
        $0.tintColor = .cyan
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
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
        nowIsPlayingLabel.text = StringURL.interstellar1?.lastPathComponent
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
        buttonStackView.roundViewWith(cornerRadius: 10, borderColor: .cyan, borderWidth: 2)
        nowIsPlayingLabel.roundViewWith(cornerRadius: 10, borderColor: .cyan, borderWidth: 2)
        musicTableView.roundViewWith(cornerRadius: 10, borderColor: .cyan, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(nowIsPlayingLabel)
        addSubview(buttonStackView)
        addSubview(musicTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nowIsPlayingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nowIsPlayingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            nowIsPlayingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: nowIsPlayingLabel.bottomAnchor, constant: 5),
            buttonStackView.heightAnchor.constraint(equalToConstant: 70),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            musicTableView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10),
            musicTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            musicTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            musicTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
