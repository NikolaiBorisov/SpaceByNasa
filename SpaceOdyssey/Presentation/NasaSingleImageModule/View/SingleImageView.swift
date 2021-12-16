//
//  SingleImageView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements and methods for SingleImageViewController
final class SingleImageView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Public Properties
    
    public var chevronRightButtonTapped: (() -> Void)?
    public var chevronLeftButtonTapped: (() -> Void)?
    public var hdButtonTapped: (() -> Void)?
    public var saveButtonTapped: (() -> Void)?
    
    public var infoLabelTopConstraint = NSLayoutConstraint()
    public var hdButtonBottomConstraint = NSLayoutConstraint()
    public var epicAndMarsInfoLabelBottomConstraint = NSLayoutConstraint()
    
    public lazy var singleImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        $0.clipsToBounds = true
        $0.addGestureRecognizer(setupLongPressGestureRecognizer())
        return $0
    }(UIImageView())
    
    public var chevronLeftButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "chevron.left.2"), for: .normal)
        $0.tintColor = .white
        $0.isHidden = true
        return $0
    }(UIButton(type: .system))
    
    public lazy var hdButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("HD", for: .normal)
        $0.setTitleColor(.cyan, for: .normal)
        $0.titleLabel?.font = .avenirNextDemiBoldOfSize(20)
        $0.isHidden = true
        return $0
    }(UIButton(type: .system))
    
    public let epicAndMarsInfoLabel: UILabelDecorator = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        $0.backgroundColor = .black
        $0.textColor = .cyan
        $0.isHidden = true
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabelDecorator())
    
    public var saveButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "square.and.arrow.up.circle"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    // MARK: - Private Properties
    
    private weak var delegate: SingleImageViewDelegate?
    private var isChevronRightButtonTapped = false
    private var isChevronLeftButtonTapped = false
    private var smallDevice = UIDevice.isSmallDevice
    
    private let topInfoLabel: UILabelDecorator = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        $0.backgroundColor = .black
        $0.textColor = .cyan
        $0.text = "Long press on picture\nfor adding to your library "
        return $0
    }(UILabelDecorator())
    
    private var chevronRightButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "chevron.right.2"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    // MARK: - Initializers
    
    init(subscriber: SingleImageViewDelegate?) {
        self.delegate = subscriber
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        setupLayout()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func longPressGestureTapped(sender: UILongPressGestureRecognizer) {
        delegate?.longPressGestureTapped()
    }
    
    @objc private func onButtonTapped(sender: UIButton) {
        switch sender {
        case chevronRightButton:
            chevronRightButtonTapped?()
        case chevronLeftButton:
            chevronLeftButtonTapped?()
        case hdButton:
            hdButtonTapped?()
        case saveButton:
            saveButtonTapped?()
        default:
            return
        }
    }
    
    // MARK: - Public Methods
    
    /// Animate alpha of any view
    public func animate(view: UIView) {
        UIView.animate(
            withDuration: 0.7,
            delay: 0.0,
            options: .curveEaseIn
        ) {
            view.alpha = 1
        }
    }
    
    /// Animate  chevronTopInfoLabel and chevronRightButton
    public func animateTopInfoLabel() {
        isChevronRightButtonTapped.toggle()
        let rotationAngle = CGFloat(Double.pi / 2)
        layoutIfNeeded()
        UIView.animate(
            withDuration: 0.3) { [self] in
                chevronRightButton.transform = isChevronRightButtonTapped ?
                CGAffineTransform(rotationAngle: rotationAngle) : CGAffineTransform.identity
                chevronRightButton.tintColor = isChevronRightButtonTapped ? .cyan : .white
                infoLabelTopConstraint.constant = isChevronRightButtonTapped ? -1 : -50
                layoutIfNeeded()
            }
    }
    
    /// Animate  chevronLeftButton and HDButton
    public func animateHDButton() {
        isChevronLeftButtonTapped.toggle()
        let rotationAngle = CGFloat(Double.pi / 2)
        layoutIfNeeded()
        UIView.animate(
            withDuration: 0.3) { [self] in
                chevronLeftButton.transform = isChevronLeftButtonTapped ?
                CGAffineTransform(rotationAngle: rotationAngle) : CGAffineTransform.identity
                chevronLeftButton.tintColor = isChevronLeftButtonTapped ? .cyan : .white
                hdButtonBottomConstraint.constant = isChevronLeftButtonTapped ? 0 : 45
                layoutIfNeeded()
            }
    }
    
    /// Animate  chevronLeftButton and EPICInfoLabel
    public func animateEPICAndMarsInfoLabel() {
        isChevronLeftButtonTapped.toggle()
        let rotationAngle = CGFloat(Double.pi / 2)
        layoutIfNeeded()
        UIView.animate(
            withDuration: 0.3) { [self] in
                chevronLeftButton.transform = isChevronLeftButtonTapped ?
                CGAffineTransform(rotationAngle: rotationAngle) : CGAffineTransform.identity
                chevronLeftButton.tintColor = isChevronLeftButtonTapped ? .cyan : .white
                epicAndMarsInfoLabelBottomConstraint.constant = isChevronLeftButtonTapped ? 0 : 45
                layoutIfNeeded()
            }
    }
    
    // MARK: - Private Methods
    
    private func setupButtonAction() {
        [chevronRightButton, chevronLeftButton, hdButton, saveButton].forEach {
            $0.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setupLongPressGestureRecognizer() -> UILongPressGestureRecognizer {
        let gestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPressGestureTapped)
        )
        gestureRecognizer.delegate = self
        gestureRecognizer.minimumPressDuration = 1
        return gestureRecognizer
    }
    
    private func setupView() {
        backgroundColor = .black
        singleImageView.alpha = 0
        singleImageView.roundViewWith(cornerRadius: 10)
        
        topInfoLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        topInfoLabel.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 1)
        
        hdButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        hdButton.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 1)
        
        epicAndMarsInfoLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        epicAndMarsInfoLabel.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 1)
    }
    
    private func addSubviews() {
        addSubview(topInfoLabel)
        addSubview(epicAndMarsInfoLabel)
        addSubview(singleImageView)
        
        singleImageView.addSubview(chevronRightButton)
        singleImageView.addSubview(chevronLeftButton)
        singleImageView.addSubview(hdButton)
        singleImageView.addSubview(saveButton)
    }
    
    private func setupLayout() {
        infoLabelTopConstraint = topInfoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -50)
        hdButtonBottomConstraint = hdButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 45)
        epicAndMarsInfoLabelBottomConstraint = epicAndMarsInfoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 45)
        
        NSLayoutConstraint.activate([
            infoLabelTopConstraint,
            topInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topInfoLabel.leadingAnchor.constraint(equalTo: chevronRightButton.trailingAnchor, constant: 10),
            
            chevronRightButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            chevronRightButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            chevronRightButton.heightAnchor.constraint(equalToConstant: 25),
            chevronRightButton.widthAnchor.constraint(equalToConstant: 25),
            
            singleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            singleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            singleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            singleImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            chevronLeftButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            chevronLeftButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            chevronLeftButton.heightAnchor.constraint(equalToConstant: 25),
            chevronLeftButton.widthAnchor.constraint(equalToConstant: 25),
            
            hdButtonBottomConstraint,
            hdButton.trailingAnchor.constraint(equalTo: chevronLeftButton.leadingAnchor, constant: -5),
            hdButton.widthAnchor.constraint(equalToConstant: smallDevice ? 110 : 120),
            hdButton.heightAnchor.constraint(equalToConstant: 45),
            
            epicAndMarsInfoLabelBottomConstraint,
            epicAndMarsInfoLabel.trailingAnchor.constraint(equalTo: chevronLeftButton.leadingAnchor, constant: -5),
            epicAndMarsInfoLabel.widthAnchor.constraint(equalToConstant: smallDevice ? 110 : 120),
            epicAndMarsInfoLabel.heightAnchor.constraint(equalToConstant: 45),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}
