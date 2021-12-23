//
//  ScreenFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 22.12.2021.
//

import UIKit

protocol ScreenFactory {
    func createCategoriesScreen(coordinator: MainCoordinator) -> UIViewController
    func createAPODScreen(coordinator: MainCoordinator) -> UIViewController
    func createEPICScreen(coordinator: MainCoordinator) -> UIViewController
    func createAsteroidsScreen(coordinator: MainCoordinator) -> UIViewController
    func createMarsRoverScreen(coordinator: MainCoordinator) -> UIViewController
    func createSingleImageScreen(coordinator: MainCoordinator) -> UIViewController
    func createTabBarController(coordinator: MainCoordinator) -> UITabBarController
}

final class ScreenFactoryImpl: ScreenFactory {
    
    // MARK: - Public Methods
    
    public func createCategoriesScreen(coordinator: MainCoordinator) -> UIViewController {
        return CategoriesViewController(coordinator: coordinator)
    }
    
    public func createAPODScreen(coordinator: MainCoordinator) -> UIViewController {
        return APODViewController(coordinator: coordinator)
    }
    
    public func createEPICScreen(coordinator: MainCoordinator) -> UIViewController {
        return EPICViewController()
    }
    
    public func createAsteroidsScreen(coordinator: MainCoordinator) -> UIViewController {
        return AsteroidViewController()
    }
    
    public func createMarsRoverScreen(coordinator: MainCoordinator) -> UIViewController {
        return MarsRoverCollectionViewController()
    }
    
    public func createSingleImageScreen(coordinator: MainCoordinator) -> UIViewController {
        return SingleImageViewController()
    }
    
    public func createTabBarController(coordinator: MainCoordinator) -> UITabBarController {
        return TabBarController(coordinator: coordinator)
    }
    
}
