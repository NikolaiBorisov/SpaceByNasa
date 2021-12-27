//
//  FavoritesCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 14.12.2021.
//

import UIKit

/// Class contains UIElements and methods for FavoritesCell
final class FavoritesCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    public var onDeleteButtonTapped: (() -> Void)?
    
    override var isSelected: Bool {
        didSet {
            isSelected ? addBorderForSelectedCell() : removeBorderForUnselectedCell()
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var activityIndicator = ActivityIndicatorView(color: .cyan, style: .medium)
    
    private var favoritesImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        return $0
    }(UIImageView())
    
    public var deleteButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(AppImage.trash, for: .normal)
        $0.tintColor = .cyan
        $0.alpha = 0
        return $0
    }(UIButton(type: .system))
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupView()
        setupLayout()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoritesImageView.image = nil
    }
    
    // MARK: - Actions
    
    @objc private func onDeleteTapped(sender: UIButton) {
        onDeleteButtonTapped?()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: Favorite) {
        guard let image = item.img else { return }
        activityIndicator.startAnimating()
        favoritesImageView.image = UIImage(data: image)
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    
    private func setupButtonAction() {
        deleteButton.addTarget(self, action: #selector(onDeleteTapped), for: .touchUpInside)
    }
    
    private func addBorderForSelectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.black.cgColor
            self.contentView.layer.borderWidth = 2
            self.contentView.layer.borderColor = UIColor.cyan.cgColor
            self.deleteButton.alpha = 1
        }
    }
    
    private func removeBorderForUnselectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.black.cgColor
            self.deleteButton.alpha = 0
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        contentView.roundViewWith(cornerRadius: 5)
        favoritesImageView.roundViewWith(cornerRadius: 5)
    }
    
    private func addSubviews() {
        contentView.addSubview(favoritesImageView)
        favoritesImageView.addSubview(activityIndicator)
        contentView.addSubview(deleteButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            favoritesImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favoritesImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoritesImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            favoritesImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: favoritesImageView.trailingAnchor, constant: -10),
            deleteButton.bottomAnchor.constraint(equalTo: favoritesImageView.bottomAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 25),
            deleteButton.heightAnchor.constraint(equalToConstant: 25),
            
            activityIndicator.centerXAnchor.constraint(equalTo: favoritesImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: favoritesImageView.centerYAnchor)
        ])
    }
    
}
