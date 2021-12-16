//
//  MarsRoverCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements and methods for MarsRoverCell
final class MarsRoverCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    override var isSelected: Bool {
        didSet {
            return isSelected ? addBorderForSelectedCell() : removeBorderForUnselectedCell()
        }
    }
    
    public var marsRoverImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private var imageCachingService = ImageCachingService()
    private lazy var activityIndicator = ActivityIndicatorView(color: .cyan, style: .medium)
    
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
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        marsRoverImageView.image = nil
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: MarsRoverDTO, indexPath: IndexPath) {
        let url = item.photos[indexPath.row].imgSrc
        activityIndicator.startAnimating()
        guard let url = URL(string: url) else { return }
        imageCachingService.getImageWith(url: url) { [weak self] image in
            guard let self = self else { return }
            self.marsRoverImageView.image = image
            self.activityIndicator.stopAnimating()
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
        marsRoverImageView.roundViewWith(cornerRadius: 5)
    }
    
    private func addSubviews() {
        contentView.addSubview(marsRoverImageView)
        marsRoverImageView.addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            marsRoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            marsRoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            marsRoverImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            marsRoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: marsRoverImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: marsRoverImageView.centerYAnchor)
        ])
    }
    
}
