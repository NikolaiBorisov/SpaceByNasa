//
//  TrackInfoView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 28.12.2021.
//

import UIKit

/// Class contains UIElements for TrackInfoViewController
final class TrackInfoView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var trackInfoTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: TrackInfoCell.self)
        $0.backgroundColor = .black
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        guard let image = AppImage.backgroundImg else { return $0 }
        $0.setBackgroundWith(image: image)
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UITableView())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .black
        trackInfoTableView.roundViewWith(cornerRadius: 10, borderColor: .cyan, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(trackInfoTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            trackInfoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            trackInfoTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            trackInfoTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            trackInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
