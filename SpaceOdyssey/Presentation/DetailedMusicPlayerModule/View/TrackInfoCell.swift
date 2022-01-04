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
    
    private lazy var trackInfoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(20)
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
            setupLayoutForCellAt(indexPath: indexPath)
            trackIcon.image = icon
        case 1:
            setupLayoutForCellAt(indexPath: indexPath)
            trackInfoLabel.text = "Author:\n\(author)"
        case 2:
            setupLayoutForCellAt(indexPath: indexPath)
            trackInfoLabel.text = "Title:\n\(title)"
        case 3:
            setupLayoutForCellAt(indexPath: indexPath)
            trackInfoLabel.text = "Duration:\n\(duration)"
        case 4:
            setupLayoutForCellAt(indexPath: indexPath)
            trackInfoLabel.textAlignment = .left
            trackInfoLabel.textColor = .cyan
            trackInfoLabel.font = .avenirNextMediumOfSize(16)
            trackInfoLabel.text = "...\n\(scene)\n..."
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
    
    private func setupLayoutForCellAt(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            contentView.addSubview(trackIcon)
            NSLayoutConstraint.activate([
                trackIcon.heightAnchor.constraint(equalToConstant: 150),
                trackIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                trackIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                trackIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        case 4:
            contentView.addSubview(trackInfoLabel)
            NSLayoutConstraint.activate([
                trackInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                trackInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                trackInfoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                trackInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
        default:
            contentView.addSubview(trackInfoLabel)
            NSLayoutConstraint.activate([
                trackInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                trackInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    }
    
}
