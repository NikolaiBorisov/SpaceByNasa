//
//  APODViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class displays APOD info
final class APODViewController: UIViewController, LoadableErrorAlertController {
    
    // MARK: - Public Properties
    
    public var viewModel = APODViewModel()
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getDataHandler()
        callBackHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
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
    
    private func getDataHandler() {
        viewModel.getData { [weak self] error in
            self?.showErrorAlertWith(title: "Oops!", message: error, completion: {
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    private func callBackHandler() {
        viewModel.setupCallback { [weak self] error in
            self?.showErrorAlertWith(title: "Oops!", message: error, completion: {
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    private func setupView() {
        viewModel.mainView.apodTableView.delegate = self
        viewModel.mainView.apodTableView.dataSource = self
    }
    
    private func setupNavBar() {
        title = viewModel.navBarTitle
        navigationItem.backButtonTitle = ""
    }
    
}

// MARK: - UITableViewDataSource

extension APODViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? APODCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: APODCell = tableView.dequeueCell(for: indexPath)
        guard let item = viewModel.apodData else { return UITableViewCell() }
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: "Information")
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension APODViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? APODCell,
              let image = cell.apodImageView.image,
              let url = viewModel.apodData?.hdurl else { return }
        let vc = SingleImageViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        vc.viewModel.navBarTitle = viewModel.apodData?.title ?? ""
        vc.viewModel.singleImage = image
        vc.viewModel.hdURL = url
        vc.viewModel.isAPODVC = true
        navigationController?.pushViewController(vc, animated: false)
    }
    
}
