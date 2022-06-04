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
    private let coordinator: MainCoordinator
    
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
        viewModel.getData()
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
    
    private func setupDelegate() {
        if let nc = tabBarController?.viewControllers?[0] as? UINavigationController,
           let vc = nc.viewControllers[0] as? MusicPlayerViewController {
            vc.delegate = self
        }
    }
    
    private func setupNavBar() {
        setupNavBarWith(
            title: Localization.mainVCTitle,
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
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppHeader.categoriesHeader)
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
        let title = viewModel.categories[indexPath.row].title
        switch indexPath.row {
        case 0: coordinator.pushAPODScreenWith(title: title)
        case 1: coordinator.pushAsteroidsScreenWith(title: title)
        case 2: coordinator.pushEPICScreenWith(title: title)
        case 3: coordinator.pushMarsRoverScreenWith(title: title)
        default: return
        }
    }
    
}

// MARK: - MusicPlayerViewControllerDelegate

extension CategoriesViewController: MusicPlayerViewControllerDelegate {
    func nextTrack(nextButtonCount: Int) {
        guard let url1 = StringURL.interstellar1,
              let url2 = StringURL.interstellar2,
              let url3 = StringURL.interstellar3 else { return }
        
        switch nextButtonCount {
        case 0: viewModel.musicPlayer.playSound(withURL: url1)
        case 1: viewModel.musicPlayer.playSound(withURL: url2)
        case 2: viewModel.musicPlayer.playSound(withURL: url3)
        default: return
        }
    }
    func play() { viewModel.musicPlayer.player?.play() }
    func pause() { viewModel.musicPlayer.player?.pause() }
    func stop() { viewModel.musicPlayer.player?.stop() }
    
}
