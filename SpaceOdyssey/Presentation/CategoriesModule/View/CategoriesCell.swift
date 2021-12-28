//
//  CategoriesCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements and methods for CategoriesCell
final class CategoriesCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var categoryTitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.font = .avenirNextMediumOfSize(21)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var categorySubtitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [categoryTitleLabel, categorySubtitleLabel]))
    
    private lazy var categoryIcon: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupCategoryIcon()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: Category) {
        categoryTitleLabel.text = item.title
        categorySubtitleLabel.text = item.subTitle
        categoryIcon.image = UIImage(named: item.image)
    }
    
    // MARK: - Private Methods
    
    private func setupCategoryIcon() {
        categoryIcon.roundViewWith(cornerRadius: categoryIcon.frame.height / 2)
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        selectionStyle = .gray
        let accessoryImage = AccessoryViewFactory.generateAccessoryViewWith(color: .lightGray)
        accessoryView = accessoryImage
    }
    
    private func addSubviews() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(categoryIcon)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: categoryIcon.leadingAnchor, constant: -5),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            categoryIcon.widthAnchor.constraint(equalToConstant: 50),
            categoryIcon.heightAnchor.constraint(equalToConstant: 50),
            categoryIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
