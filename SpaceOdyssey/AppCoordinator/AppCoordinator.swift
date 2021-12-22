//
//  AppCoordinator.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 22.12.2021.
//

import UIKit

protocol AppCoordinator: Coordinator {
    func pushAPODScreen()
    func pushAsteroidsScreen()
    func pushEPICModuleScreen()
    func pushMarsRoverScreen()
    func pushSingleImageScreen()
}

final class AppCoordinatorImpl: AppCoordinator {
    
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
        let vc = screenFactory.createCategoriesScreen()
        pushController(controller: vc, animated: true)
    }
    
    func pushAPODScreen() {
        let vc = screenFactory.createAPODScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushAsteroidsScreen() {
        let vc = screenFactory.createAsteroidsScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushEPICModuleScreen() {
        let vc = screenFactory.createEPICScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushMarsRoverScreen() {
        let vc = screenFactory.createMarsRoverScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
    func pushSingleImageScreen() {
        let vc = screenFactory.createSingleImageScreen(coordinator: self)
        pushController(controller: vc, animated: true)
    }
    
}
