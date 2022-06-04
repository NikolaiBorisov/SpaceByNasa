//
//  GalleryView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 26.12.2021.
//

import UIKit

/// Class contains UIElements and methods for GalleryCollectionViewController
final class GalleryView: UIView {
    
    // MARK: - Public Properties
    
    public let galleryCollectionView: UICollectionView = {
        let layout = ZoomAndSnapFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell: GalleryCell.self)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.contentInsetAdjustmentBehavior = .always
        guard let image = AppImage.backgroundImg else { return collectionView }
        collectionView.setBackgroundWith(image: image)
        return collectionView
    }()
    
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
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(galleryCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            galleryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            galleryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            galleryCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
