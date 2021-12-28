//
//  TrackInfoViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 28.12.2021.
//

import UIKit

/// Class displays detailed track info
final class TrackInfoViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var viewModel = TrackInfoViewModel()
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.mainView.trackInfoTableView.reloadData()
    }
    
    // MARK: - Initializers
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        setupNavBarWith(
            title: Localization.musicVCTitle,
            font: .avenirNextDemiBoldOfSize(35)
        )
    }
    
    private func setupView() {
        viewModel.mainView.trackInfoTableView.delegate = self
        viewModel.mainView.trackInfoTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension TrackInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackInfoCell = tableView.dequeueCell(for: indexPath)
        cell.configureCell(
            icon: viewModel.icon,
            author: viewModel.author,
            title: viewModel.title,
            duration: viewModel.duration,
            scene: viewModel.scene,
            at: indexPath
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppHeader.trackHeader, color: .cyan)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension TrackInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 170
        case 4:
            tableView.rowHeight = UITableView.automaticDimension
            return tableView.rowHeight
        default: return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
