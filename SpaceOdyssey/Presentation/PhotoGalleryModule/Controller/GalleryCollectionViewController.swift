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
        photos: [Photo]
    ) {
        self.coordinator = coordinator
        self.viewModel.photoArray = photos
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
        title = Localization.gallery
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }
    
}

// MARK: - UICollectionViewDataSource

extension GalleryCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: GalleryCell = collectionView.dequeueCell(for: indexPath)
        let item =  viewModel.photoArray[indexPath.row]
        cell.configureCell(with: item)
        return cell
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
            height: viewModel.isSmallDevice ? 250 : 350
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
