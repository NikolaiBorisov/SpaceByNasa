//
//  SingleImageViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit
import CoreData

/// Class displays a single image
final class SingleImageViewController: UIViewController, LoadableInfoAlertController {
    
    // MARK: - Public Properties
    
    public var viewModel = SingleImageViewModel()
    public lazy var mainView = SingleImageView(subscriber: self)
    public weak var coordinator: MainCoordinatorImpl?
    
    // MARK: - Private Properties
    
    private var coreDataManager = CoreDataManagerImpl.shared
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        animateView()
        setupCallback()
        setupHDButton()
        setupEPICInfoLabel()
        setupMarsRoverInfoLabel()
    }
    
    // MARK: - Private Methods
    
    private func setupHDButton() {
        if viewModel.isAPODVC ?? false {
            mainView.hdButton.isHidden = false
            mainView.chevronLeftButton.isHidden = false
        }
    }
    
    private func setupEPICInfoLabel() {
        if viewModel.isEPICVC ?? false {
            mainView.epicAndMarsInfoLabel.isHidden = false
            mainView.chevronLeftButton.isHidden = false
        }
    }
    
    private func setupMarsRoverInfoLabel() {
        if viewModel.isMarsRover ?? false {
            mainView.epicAndMarsInfoLabel.isHidden = false
            mainView.chevronLeftButton.isHidden = false
        }
    }
    
    private func setupView() {
        mainView.singleImageView.image = viewModel.singleImage
    }
    
    private func animateView() {
        mainView.animate(view: mainView.singleImageView)
    }
    
    private func setupNavBar() {
        title = viewModel.navBarTitle
    }
    
    public func setupCallback() {
        mainView.chevronRightButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.mainView.animateTopInfoLabel()
        }
        
        mainView.chevronLeftButtonTapped = { [weak self] in
            guard let self = self else { return }
            if self.viewModel.isAPODVC ?? false {
                self.mainView.animateHDButton()
            }
            if self.viewModel.isEPICVC ?? false {
                self.mainView.animateEPICAndMarsInfoLabel()
            }
            if self.viewModel.isMarsRover ?? false {
                self.mainView.animateEPICAndMarsInfoLabel()
            }
        }
        
        mainView.hdButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.openSite(urlString: self.viewModel.hdURL)
        }
        
        mainView.saveButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.showInfoAlertWith(
                title: "Would You Like to Save this Photo?",
                message: "Photo Will Be Saved to Favorites") { [weak self] in
                    guard let self = self else { return nil }
                    self.saveImgHandler()
                    self.showInfoAlertWith(
                        title: "Photo Successfully Saved to Favorites",
                        message: "Open Favorites?") {
                            let vc = FavoritesViewController()
                            return self.navigationController?.pushViewController(vc, animated: true)
                        } completionCancel: {}
                    return self.mainView.saveButton.isHidden = true
                } completionCancel: {}
        }
    }
    
    private func saveImgHandler() {
        if let png = self.mainView.singleImageView.image?.pngData() {
            let context = coreDataManager.getContext()
            let pngObject = coreDataManager.createObject(from: Favorite.self)
            pngObject.img = png
            coreDataManager.save(context: context)
        }
    }
    
}

// MARK: - SingleImageViewDelegate

extension SingleImageViewController: SingleImageViewDelegate {
    
    func longPressGestureTapped() {
        viewModel.createActivityViewControllerWith(item: viewModel.singleImage, on: self)
    }
    
}
