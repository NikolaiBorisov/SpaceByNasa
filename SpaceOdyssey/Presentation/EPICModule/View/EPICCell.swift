//
//  EPICCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class contains UIElements and methods for EPICCell
final class EPICCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var epicImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private var imageCachingService = ImageCachingService()
    private lazy var activityIndicator = ActivityIndicatorView(color: .cyan, style: .medium)
    
    public let dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var labelAndImageStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [dateLabel, epicImageView]))
    
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
        
        setupEpicImageView()
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
    
    public func configureFirstSectionCell(with item: EpicDTO) {
        dateLabel.text = item.caption + "." + "\nDiscover the picture of the Earth at specific time"
        dateLabel.font = .avenirNextMediumOfSize(16)
        dateLabel.textAlignment = .center
        epicImageView.removeFromSuperview()
    }
    
    public func configureSecondSectionCell(with item: EpicDTO) {
        let date = item.date.dropLast(9).replacingOccurrences(of: "-", with: "/")
        let image = item.image
        dateLabel.text = "Taken \(item.date.replacingOccurrences(of: " ", with: " at "))"
        setupEPICImageWith(date: date, image: image)
    }
    
    // MARK: - Private Methods
    
    private func setupEPICImageWith(date: String, image: String) {
        let url = StringURL.epicURLImage(date, image)
        activityIndicator.startAnimating()
        epicImageView.setupImageFor(view: epicImageView, service: imageCachingService, url: url) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
    }
    
    private func setupEpicImageView() {
        epicImageView.roundViewWith(cornerRadius: epicImageView.frame.width / 2)
    }
    
    private func addSubviews() {
        contentView.addSubview(labelAndImageStackView)
        epicImageView.addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelAndImageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelAndImageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            labelAndImageStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelAndImageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            activityIndicator.centerXAnchor.constraint(equalTo: epicImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: epicImageView.centerYAnchor),
            
            epicImageView.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
}
