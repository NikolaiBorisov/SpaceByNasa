//
//  TrackInfoCell.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 28.12.2021.
//

import UIKit

/// Class contains UIElements and methods for TrackInfoCell
final class TrackInfoCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var trackIcon: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var trackAuthorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var trackTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var trackDurationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var movieSceneLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.textColor = .cyan
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupTrackIcon()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(
        icon: UIImage,
        author: String,
        title: String,
        duration: String,
        scene: String,
        at indexPath: IndexPath
    ) {
        switch indexPath.row {
        case 0:
            trackIcon.image = icon
            setupLayoutForIconCell()
        case 1:
            setupLayoutForAuthorLabelCell()
            trackAuthorLabel.text = "Author:\n\(author)"
        case 2:
            setupLayoutForTrackTitleLabelCell()
            trackTitleLabel.text = "Title:\n\(title)"
        case 3:
            setupLayoutForTrackDurationLabelCell()
            trackDurationLabel.text = "Duration:\n\(duration)"
        case 4:
            setupLayoutForMovieSceneLabelCell()
            movieSceneLabel.text = "...\n\(scene)\n..."
        default: break
        }
    }
    
    // MARK: - Private Methods
    
    private func setupTrackIcon() {
        trackIcon.roundViewWith(cornerRadius: 10)
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        selectionStyle = .none
    }
    
    private func setupLayoutForIconCell() {
        contentView.addSubview(trackIcon)
        NSLayoutConstraint.activate([
            trackIcon.heightAnchor.constraint(equalToConstant: 150),
            trackIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            trackIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trackIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupLayoutForAuthorLabelCell() {
        contentView.addSubview(trackAuthorLabel)
        NSLayoutConstraint.activate([
            trackAuthorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trackAuthorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupLayoutForTrackTitleLabelCell() {
        contentView.addSubview(trackTitleLabel)
        NSLayoutConstraint.activate([
            trackTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trackTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupLayoutForTrackDurationLabelCell() {
        contentView.addSubview(trackDurationLabel)
        NSLayoutConstraint.activate([
            trackDurationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trackDurationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupLayoutForMovieSceneLabelCell() {
        contentView.addSubview(movieSceneLabel)
        NSLayoutConstraint.activate([
            movieSceneLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieSceneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieSceneLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieSceneLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
}
