//
//  AsteroidCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.12.2021.
//

import UIKit

/// Class contains UIElements and methods for AsteroidCell
final class AsteroidCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var asteroidImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = AppImage.asteroid
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(20)
        return $0
    }(UILabel())
    
    private let fullNameLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private let absoluteMagnitudeLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.adjustsFontSizeToFitWidth = true
        $0.font = .avenirNextMediumOfSize(16)
        return $0
    }(UILabel())
    
    private let diameterLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.adjustsFontSizeToFitWidth = true
        $0.font = .avenirNextMediumOfSize(16)
        return $0
    }(UILabel())
    
    private let hazardStateLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.adjustsFontSizeToFitWidth = true
        $0.font = .avenirNextMediumOfSize(16)
        return $0
    }(UILabel())
    
    private let firstDiscoveredLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(16)
        return $0
    }(UILabel())
    
    private lazy var labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [
        nameLabel,
        fullNameLabel,
        absoluteMagnitudeLabel,
        diameterLabel,
        hazardStateLabel,
        firstDiscoveredLabel
    ]))
    
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
        
        setupAsteroidImageView()
    }
    
    // MARK: - Public Methods
    
    /// Animate cell appearance
    public func animateCell(at indexPath: IndexPath) {
        transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(
            withDuration: 0.3,
            delay: 0.02 * Double(indexPath.row),
            animations: { [self] in
                transform = CGAffineTransform(
                    translationX: contentView.frame.width,
                    y: contentView.frame.height
                )
            })
    }
    
    public func configureCell(with item: NearEarthObject) {
        let name = item.nameLimited
        let fullName = item.name
        let magnitude = item.absoluteMagnitudeH
        let diameter = item.estimatedDiameter.kilometers.estimatedDiameterMax
        let isHazardous = item.isPotentiallyHazardousAsteroid
        let firstDiscovered = item.orbitalData.firstObservationDate
        nameLabel.text = "Name: \(name)"
        fullNameLabel.text = "Full Name: \(fullName)"
        absoluteMagnitudeLabel.text = "Magnitude(h): \(magnitude)"
        diameterLabel.text = "Diameter(km): " + String(format: "%.2f", diameter)
        hazardStateLabel.text = "Hazardous: \(isHazardous)"
        firstDiscoveredLabel.text = "Discovered: \(firstDiscovered)"
    }
    
    // MARK: - Private Methods
    
    private func setupAsteroidImageView() {
        asteroidImageView.roundViewWith(cornerRadius: asteroidImageView.frame.width / 2)
    }
    
    private func setupView() {
        let accessoryImage = AccessoryViewFactory.generateAccessoryViewWith(color: .lightGray)
        contentView.superview?.backgroundColor = .black
        selectionStyle = .gray
        accessoryView = accessoryImage
    }
    
    private func addSubviews() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(asteroidImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            asteroidImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            asteroidImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            asteroidImageView.widthAnchor.constraint(equalToConstant: 100),
            asteroidImageView.heightAnchor.constraint(equalToConstant: 100),
            
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: asteroidImageView.leadingAnchor, constant: 0),
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}
