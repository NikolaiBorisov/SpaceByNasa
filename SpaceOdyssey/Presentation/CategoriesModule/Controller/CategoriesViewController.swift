//
//  CategoriesViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class displays the categories of NASAData
final class CategoriesViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel = CategoriesViewModel()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        viewModel.playMusic()
        setupDelegate()
    }
    
    // MARK: - Private Methods
    
    private func setupDelegate() {
        if let nc = tabBarController?.viewControllers?[0] as? UINavigationController,
           let vc = nc.viewControllers[0] as? MusicPlayerViewController {
            vc.delegate = self
        }
    }
    
    private func setupNavBar() {
        setupNavBarWith(
            title: Localization.vcTitle,
            font: viewModel.isRuLocale ? .avenirNextDemiBoldOfSize(25) : .avenirNextDemiBoldOfSize(35)
        )
    }
    
    private func setupView() {
        viewModel.mainView.categoriesTableView.delegate = self
        viewModel.mainView.categoriesTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CategoriesCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoriesCell = tableView.dequeueCell(for: indexPath)
        let item = viewModel.categories[indexPath.row]
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: "Choose Category")
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.mainView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = APODViewController()
            vc.viewModel.navBarTitle = viewModel.categories[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = AsteroidViewController()
            vc.viewModel.navBarTitle = viewModel.categories[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = EPICViewController()
            vc.viewModel.navBarTitle = viewModel.categories[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = MarsRoverCollectionViewController()
            vc.viewModel.navBarTitle = viewModel.categories[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
}

// MARK: - MusicPlayerViewControllerDelegate

extension CategoriesViewController: MusicPlayerViewControllerDelegate {
    func nextTrack(isNextButtonTapped: Bool) {
        guard let url1 = StringURL.zemlyane,
              let url2 = StringURL.mainThemeMusic else { return }
        switch isNextButtonTapped {
        case true:
            viewModel.musicPlayer.playSound(withURL: url1)
        case false:
            viewModel.musicPlayer.playSound(withURL: url2)
        }
    }
    func play() { viewModel.musicPlayer.player?.play() }
    func pause() { viewModel.musicPlayer.player?.pause() }
    func stop() { viewModel.musicPlayer.player?.stop() }
    
}
