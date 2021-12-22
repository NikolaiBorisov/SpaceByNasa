//
//  ScreenFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 22.12.2021.
//

import UIKit

protocol ScreenFactory {
    func createCategoriesScreen() -> UIViewController
    func createAPODScreen(coordinator: AppCoordinator) -> UIViewController
    func createEPICScreen(coordinator: AppCoordinator) -> UIViewController
    func createAsteroidsScreen(coordinator: AppCoordinator) -> UIViewController
    func createMarsRoverScreen(coordinator: AppCoordinator) -> UIViewController
    func createSingleImageScreen(coordinator: AppCoordinator) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    
    // MARK: - Public Methods
    
    public func createCategoriesScreen() -> UIViewController {
        return CategoriesViewController()
    }
    
    public func createAPODScreen(coordinator: AppCoordinator) -> UIViewController {
        return APODViewController()
    }
    
    public func createEPICScreen(coordinator: AppCoordinator) -> UIViewController {
        return EPICViewController()
    }
    
    public func createAsteroidsScreen(coordinator: AppCoordinator) -> UIViewController {
        return AsteroidViewController()
    }
    
    public func createMarsRoverScreen(coordinator: AppCoordinator) -> UIViewController {
        return MarsRoverCollectionViewController()
    }
    
    public func createSingleImageScreen(coordinator: AppCoordinator) -> UIViewController {
        return SingleImageViewController()
    }
    
}
