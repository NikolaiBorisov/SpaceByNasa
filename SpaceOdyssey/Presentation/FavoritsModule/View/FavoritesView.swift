//
//  FavoritesView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 14.12.2021.
//

import UIKit

/// Class contains UIElements and methods for ViewController
final class FavoritesView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    
    public let favoritesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell: FavoritesCell.self)
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = true
        return collectionView
    }()
    
    public lazy var collectionViewRefreshControl = RefreshControlFactory.generate()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func refreshData(sender: UIRefreshControl) {
        refreshControlPulled?()
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        favoritesCollectionView.refreshControl = collectionViewRefreshControl
        collectionViewRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(favoritesCollectionView)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            favoritesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoritesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
