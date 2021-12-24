//
//  MainCoordinator.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 22.12.2021.
//

import UIKit

protocol MainCoordinator: Coordinator {
    func pushAPODScreenWith(title: String)
    func pushAsteroidsScreenWith(title: String)
    func pushEPICScreenWith(title: String)
    func pushMarsRoverScreenWith(title: String)
    func pushFavoritesScreen()
    func pushMusicPlayerScreen()
    
    func pushSingleImageScreenWith(
        title: String,
        image: UIImage,
        url: String,
        isAPODVC: Bool,
        isEPICVC: Bool,
        isMarsRover: Bool,
        infoText: String
    )
}

final class MainCoordinatorImpl: MainCoordinator {
    
    // MARK: - Public Properties
    
    public var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private let screenFactory: ScreenFactory
    
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController,
        screenFactory: ScreenFactory = ScreenFactoryImpl()
    ) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let vc = screenFactory.createCategoriesScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushAPODScreenWith(title: String) {
        let vc = screenFactory.createAPODScreenWith(coordinator: self, title: title)
        pushController(controller: vc, animated: true)
    }
    
    func pushAsteroidsScreenWith(title: String) {
        let vc = screenFactory.createAsteroidsScreen(coordinator: self, title: title)
        pushController(controller: vc, animated: true)
    }
    
    func pushEPICScreenWith(title: String) {
        let vc = screenFactory.createEPICScreen(coordinator: self, title: title)
        pushController(controller: vc, animated: true)
    }
    
    func pushMarsRoverScreenWith(title: String) {
        let vc = screenFactory.createMarsRoverScreen(coordinator: self, title: title)
        pushController(controller: vc, animated: true)
    }
    
    func pushFavoritesScreen() {
        let vc = screenFactory.createFavoritesScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushMusicPlayerScreen() {
        let vc = screenFactory.createMusicPlayerScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushSingleImageScreenWith(
        title: String,
        image: UIImage,
        url: String,
        isAPODVC: Bool,
        isEPICVC: Bool,
        isMarsRover: Bool,
        infoText: String
    ) {
        let vc = screenFactory.createSingleImageScreen(
            coordinator: self,
            title: title,
            image: image,
            url: url,
            isAPODVC: isAPODVC,
            isEPICVC: isEPICVC,
            isMarsRover: isMarsRover,
            infoText: infoText
        )
        pushController(controller: vc, animated: true)
    }
    
}
