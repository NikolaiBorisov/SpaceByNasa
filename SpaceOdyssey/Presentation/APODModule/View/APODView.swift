//
//  APODView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class contains UIElements and methods for APODViewController
final class APODView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    
    public lazy var apodTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.register(cell: APODCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.rowHeight = UITableView.automaticDimension
        $0.autoresizesSubviews = true
        $0.alpha = 0
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
        apodTableView.refreshControl = tableRefreshControl
        tableRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(apodTableView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            apodTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            apodTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            apodTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            apodTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
