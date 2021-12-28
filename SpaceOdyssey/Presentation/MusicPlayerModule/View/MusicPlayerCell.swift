//
//  MusicPlayerCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 27.12.2021.
//

import UIKit

/// Class contains UIElements and methods for MusicPlayerCell
final class MusicPlayerCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public lazy var trackTitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 1
        $0.font = .avenirNextMediumOfSize(16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    public lazy var trackAuthorLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.font = .avenirNextMediumOfSize(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    public lazy var trackIcon: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    public lazy var trackDurationLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    // MARK: - Private Properties
    
    private lazy var labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [trackAuthorLabel, trackTitleLabel, trackDurationLabel]))
    
    private lazy var equaliser: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
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
        
        setupImageView()
    }
    
    // MARK: - Public Methods
    
    public func setupEqualiser() {
        equaliser.loadGif(name: Gif.equaliser)
    }
    
    public func configureCell(with item: Track) {
        trackAuthorLabel.text = item.author
        trackTitleLabel.text = item.title
        trackDurationLabel.text = "\(item.duration)"
        trackIcon.image = item.icon
    }
    
    // MARK: - Private Methods
    
    private func setupImageView() {
        trackIcon.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
        equaliser.roundViewWith(cornerRadius: 10)
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
        contentView.addSubview(equaliser)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: trackIcon.leadingAnchor, constant: -5),
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            trackIcon.widthAnchor.constraint(equalToConstant: 80),
            trackIcon.heightAnchor.constraint(equalToConstant: 80),
            trackIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trackIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            equaliser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            equaliser.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            equaliser.topAnchor.constraint(equalTo: trackIcon.bottomAnchor),
            equaliser.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
}
