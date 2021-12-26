//
//  EPICView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class contains UIElements and methods for EPICViewController
final class EPICView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    
    public lazy var epicTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: EPICCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
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
    
    // MARK: - Actions
    
    @objc private func refreshData(sender: UIRefreshControl) {
        refreshControlPulled?()
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        epicTableView.refreshControl = tableRefreshControl
        tableRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(epicTableView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            epicTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            epicTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            epicTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            epicTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
