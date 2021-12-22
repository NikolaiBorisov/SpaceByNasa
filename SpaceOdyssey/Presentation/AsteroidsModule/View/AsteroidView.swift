//
//  AsteroidView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.12.2021.
//

import UIKit

/// Class contains UIElements and methods for AsteroidViewController
final class AsteroidView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    
    public lazy var asteroidTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: AsteroidCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.rowHeight = UITableView.automaticDimension
        $0.autoresizesSubviews = true
        return $0
    }(UITableView())
    
    public lazy var activityIndicator = ActivityIndicatorView(color: .cyan, style: .large)
    public lazy var tableRefreshControl = RefreshControlFactory.generate()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
        setupRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.setupActivityIndicatorOn(view: self)
    }
    
    // MARK: - Public Methods
    
    @objc private func refreshData(sender: UIRefreshControl) {
        refreshControlPulled?()
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        asteroidTableView.refreshControl = tableRefreshControl
        tableRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(asteroidTableView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            asteroidTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            asteroidTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            asteroidTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            asteroidTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
