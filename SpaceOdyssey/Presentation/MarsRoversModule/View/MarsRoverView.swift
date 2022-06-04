//
//  MarsRoverView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements and methods for MarsRoverCollectionViewController
final class MarsRoverView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    
    public let marsRoverCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell: MarsRoverCell.self)
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = true
        guard let image = AppImage.backgroundImg else { return collectionView }
        collectionView.setBackgroundWith(image: image)
        return collectionView
    }()
    
    public lazy var activityIndicator = ActivityIndicatorView(color: .cyan, style: .large)
    public lazy var collectionViewRefreshControl = RefreshControlFactory.generate()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
        setupRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.setupActivityIndicatorOn(view: self)
    }
    
    // MARK: - Actions
    
    @objc private func refreshData(sender: UIRefreshControl) {
        refreshControlPulled?()
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        marsRoverCollectionView.refreshControl = collectionViewRefreshControl
        collectionViewRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(marsRoverCollectionView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            marsRoverCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            marsRoverCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            marsRoverCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            marsRoverCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
