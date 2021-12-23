//
//  AsteroidViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.12.2021.
//

import UIKit

/// Class displays Asteroids info
final class AsteroidViewController: UIViewController, LoadableErrorAlertController, LoadableInfoAlertController {
    
    // MARK: - Public Properties
    
    public var viewModel = AsteroidViewModel()
    public weak var coordinator: MainCoordinatorImpl?
    
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
        viewModel.mainView.asteroidTableView.delegate = self
        viewModel.mainView.asteroidTableView.dataSource = self
    }
    
    private func setupNavBar() {
        title = viewModel.navBarTitle
        navigationItem.backButtonTitle = ""
    }
    
}

// MARK: - UITableViewDataSource

extension AsteroidViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objects = viewModel.asteroidData?.nearEarthObjects
        return objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? AsteroidCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AsteroidCell = tableView.dequeueCell(for: indexPath)
        guard let item = viewModel.asteroidData?.nearEarthObjects[indexPath.row] else { return UITableViewCell() }
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

extension AsteroidViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let itemID = viewModel.asteroidData?.nearEarthObjects[indexPath.row].id else { return }
        let url = StringURL.asteroidViewURL(itemID)
        showInfoAlertWith(
            title: "Note",
            message: "On the Following Web Page You Will Find the Selected Asteroid on the White Circle by its Name.\nEvery Next Visit you Have to Reload the Web Page, to See the New Selected Asteroid\n🪨") { [weak self] in
                self?.viewModel.openSite(urlString: url)
            } completionCancel: {}
    }
    
}
