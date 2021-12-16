//
//  APODCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements and methods for APODCell
final class APODCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var apodImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private var imageCachingService = ImageCachingService()
    private lazy var activityIndicator = ActivityIndicatorView(color: .cyan, style: .medium)
    
    private let titleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        return $0
    }(UILabel())
    
    private let explanationLabel: UILabel = {
        $0.textAlignment = .justified
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(16)
        return $0
    }(UILabel())
    
    private let copyrightLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        return $0
    }(UILabel())
    
    private lazy var labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [titleLabel, dateLabel, explanationLabel, copyrightLabel]))
    
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
        
        setupAPODImageView()
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
    
    public func configureCell(with item: ApodDTO) {
        guard let imageURL = URL(string: item.url) else { return }
        
        activityIndicator.startAnimating()
        imageCachingService.getImageWith(url: imageURL) { [weak self] image in
            guard let self = self else { return }
            self.apodImageView.image = image
            self.activityIndicator.stopAnimating()
        }
        
        titleLabel.text = "Title: \(item.title)"
        dateLabel.text = "Date: \(item.date)"
        explanationLabel.text = item.explanation
        copyrightLabel.text = "Copyright: \(item.copyright ?? "-")"
    }
    
    // MARK: - Private Methods
    
    private func setupAPODImageView() {
        apodImageView.layer.cornerCurve = .continuous
        apodImageView.layer.cornerRadius = apodImageView.frame.width / 2
    }
    
    private func setupView() {
        let accessoryImage = AccessoryViewFactory.generateAccessoryViewWith(color: .lightGray)
        contentView.superview?.backgroundColor = .black
        selectionStyle = .gray
        accessoryView = accessoryImage
    }
    
    private func addSubviews() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(apodImageView)
        apodImageView.addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            apodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            apodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            apodImageView.widthAnchor.constraint(equalToConstant: 100),
            apodImageView.heightAnchor.constraint(equalToConstant: 100),
            
            activityIndicator.centerXAnchor.constraint(equalTo: apodImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: apodImageView.centerYAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelStackView.topAnchor.constraint(equalTo: apodImageView.bottomAnchor, constant: 5),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}
