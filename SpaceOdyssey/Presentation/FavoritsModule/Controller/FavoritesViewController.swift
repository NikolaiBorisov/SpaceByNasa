//
//  FavoritesViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 14.12.2021.
//

import UIKit

/// Class displays saved favourites photos
final class FavoritesViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: MainCoordinatorImpl?
    
    // MARK: - Private Properties
    
    private var viewModel = FavoritesViewModel()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.setupCallback()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchDataFromCoreData()
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        setupNavBarWith(
            title: "Favorites",
            font: .avenirNextDemiBoldOfSize(35)
        )
    }
    
    private func setupView() {
        viewModel.mainView.favoritesCollectionView.delegate = self
        viewModel.mainView.favoritesCollectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imgArrayCD.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        guard let cell = collectionView.cellForItem(at: indexPath) as? FavoritesCell else { return }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: FavoritesCell = collectionView.dequeueCell(for: indexPath)
        let item = viewModel.imgArrayCD[indexPath.row]
        cell.configureCell(with: item)
        cell.onDeleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.coreDataManager.delete(object: item)
            self.viewModel.imgArrayCD.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellSpacing: CGFloat = viewModel.insetForSection.left
        let itemsPerRow: CGFloat = 2
        let spacing = (itemsPerRow * cellSpacing) + ((itemsPerRow - 1.0) * cellSpacing)
        let size = (collectionView.bounds.width - spacing) / itemsPerRow
        return CGSize(width: size, height: size)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        viewModel.insetForSection
    }
    
}
