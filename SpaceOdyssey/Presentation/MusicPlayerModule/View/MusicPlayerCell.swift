//
//  MusicPlayerCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

final class MusicPlayerCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public lazy var trackTitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.font = .avenirNextMediumOfSize(21)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    // MARK: - Private Properties
    
    private lazy var trackSubtitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
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
    }(UIStackView(arrangedSubviews: [trackTitleLabel, trackSubtitleLabel]))
    
    private lazy var trackIcon: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
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
        
        setupNasaLogo()
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
    
    public func configureCell(with item: Music) {
        trackTitleLabel.text = item.title
        trackSubtitleLabel.text = "\(item.duration)"
        trackIcon.image = item.icon
    }
    
    // MARK: - Private Methods
    
    private func setupNasaLogo() {
        trackIcon.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        selectionStyle = .gray
        let accessoryImage = AccessoryViewFactory.generateAccessoryViewWith(color: .lightGray)
        accessoryView = accessoryImage
    }
    
    private func addSubviews() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(trackIcon)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: trackIcon.leadingAnchor, constant: -5),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            trackIcon.widthAnchor.constraint(equalToConstant: 50),
            trackIcon.heightAnchor.constraint(equalToConstant: 50),
            trackIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trackIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
