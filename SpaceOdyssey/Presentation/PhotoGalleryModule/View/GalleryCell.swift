//
//  GalleryCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 26.12.2021.
//

import UIKit

/// Class contains UIElements and methods for GalleryCell
final class GalleryCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    override var isSelected: Bool {
        didSet {
            return isSelected ? addBorderForSelectedCell() : removeBorderForUnselectedCell()
        }
    }
    
    public var galleryImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private var imageCachingService = ImageCachingService()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configureCellWith(marsItem: Photo?, favoriteItem: Favorite?, isMarsRover: Bool) {
        switch isMarsRover {
        case true:
            guard let url = marsItem?.imgSrc else { return }
            galleryImageView.setupImageFor(view: galleryImageView, service: imageCachingService, url: url) {}
        case false:
            guard let image = favoriteItem?.img else { return }
            galleryImageView.image = UIImage(data: image)
        }
        
    }
    
    // MARK: - Private Methods
    
    private func addBorderForSelectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.black.cgColor
            self.contentView.layer.borderWidth = 2
            self.contentView.layer.borderColor = UIColor.cyan.cgColor
        }
    }
    
    private func removeBorderForUnselectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.roundViewWith(cornerRadius: 5)
        galleryImageView.roundViewWith(cornerRadius: 5)
    }
    
    private func addSubviews() {
        contentView.addSubview(galleryImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            galleryImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            galleryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            galleryImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            galleryImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
}
