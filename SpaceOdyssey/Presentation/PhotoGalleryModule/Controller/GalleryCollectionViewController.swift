//
//  GalleryCollectionViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 26.12.2021.
//

import UIKit

/// Class presents PhotoGallery
final class GalleryCollectionViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var viewModel = GalleryViewModel()
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        marsPhotos: [Photo],
        favoritesPhotos: [Favorite],
        isMarsRover: Bool
    ) {
        self.coordinator = coordinator
        self.viewModel.marsPhotos = marsPhotos
        self.viewModel.favoritesPhotos = favoritesPhotos
        self.viewModel.isMarsRover = isMarsRover
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        viewModel.mainView.galleryCollectionView.delegate = self
        viewModel.mainView.galleryCollectionView.dataSource = self
    }
    
    private func setupNavBar() {
        if viewModel.isMarsRover ?? false {
            title = Localization.marsGallery
        } else {
            title = Localization.favoritesGallery
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }
    
}

// MARK: - UICollectionViewDataSource

extension GalleryCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.isMarsRover {
        case true: return viewModel.marsPhotos.count
        case false: return viewModel.favoritesPhotos.count
        case .none: return 0
        case .some(_): return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: GalleryCell = collectionView.dequeueCell(for: indexPath)
        guard let isMarsRover = viewModel.isMarsRover else { return cell }
        switch viewModel.isMarsRover {
        case true:
            let item = viewModel.marsPhotos[indexPath.row]
            cell.configureCellWith(marsItem: item, favoriteItem: nil, isMarsRover: isMarsRover)
            return cell
        case false:
            let item = viewModel.favoritesPhotos[indexPath.row]
            cell.configureCellWith(marsItem: nil, favoriteItem: item, isMarsRover: isMarsRover)
            return cell
        case .none: return cell
        case .some(_): return cell
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: viewModel.screenWidth / 2,
            height: viewModel.screenHeight / 2.5
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        viewModel.insetForSection
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .cyan
    }
    
}
