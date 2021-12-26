//
//  MarsRoverCollectionViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class presents MarsRover photos
final class MarsRoverCollectionViewController: UIViewController, LoadableErrorAlertController {
    
    // MARK: - Public Properties
    
    public var viewModel = MarsRoverViewModel()
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        title: String
    ) {
        self.coordinator = coordinator
        self.viewModel.navBarTitle = title
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
        getDataHandler()
        callBackHandler()
    }
    
    // MARK: - Private Methods
    
    private func getDataHandler() {
        viewModel.getMarsRoverPhotos { [weak self] error in
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
        viewModel.mainView.marsRoverCollectionView.delegate = self
        viewModel.mainView.marsRoverCollectionView.dataSource = self
    }
    
    private func setupNavBar() {
        title = viewModel.navBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }
    
}

// MARK: - UICollectionViewDataSource

extension MarsRoverCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = viewModel.marsRoverPhotos?.photos else { return 0 }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        guard let cell = collectionView.cellForItem(at: indexPath) as? MarsRoverCell else { return }
        guard let image = cell.marsRoverImageView.image else { return }
        
        let title = viewModel.marsRoverPhotos?.photos[indexPath.row].camera.fullName.rawValue ?? ""
        let landingDate = viewModel.marsRoverPhotos?.photos[indexPath.row].rover.landingDate
        let sol = viewModel.marsRoverPhotos?.photos[indexPath.row].sol
        
        coordinator.pushSingleImageScreenWith(
            title: title,
            image: image,
            url: "",
            isAPODVC: false,
            isEPICVC: false,
            isMarsRover: true,
            infoText: "Landed: \(landingDate ?? "")\nSol: \(sol ?? 0)"
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: MarsRoverCell = collectionView.dequeueCell(for: indexPath)
        guard let item = viewModel.marsRoverPhotos?.photos[indexPath.row] else { return UICollectionViewCell() }
        cell.configureCell(with: item)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MarsRoverCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
