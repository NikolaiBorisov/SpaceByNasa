//
//  ScreenFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 22.12.2021.
//

import UIKit

protocol ScreenFactory {
    func createCategoriesScreen(coordinator: MainCoordinator) -> UIViewController
    func createAPODScreenWith(coordinator: MainCoordinator, title: String) -> UIViewController
    func createAsteroidsScreen(coordinator: MainCoordinator, title: String) -> UIViewController
    func createEPICScreen(coordinator: MainCoordinator, title: String) -> UIViewController
    func createMarsRoverScreen(coordinator: MainCoordinator, title: String) -> UIViewController
    func createTabBarController(coordinator: MainCoordinator) -> UITabBarController
    func createFavoritesScreen(coordinator: MainCoordinator) -> UIViewController
    func createMusicPlayerScreen(coordinator: MainCoordinator) -> UIViewController
    
    func createSingleImageScreen(
        coordinator: MainCoordinator,
        title: String,
        image: UIImage,
        url: String,
        isAPODVC: Bool,
        isEPICVC: Bool,
        isMarsRover: Bool,
        infoText: String
    ) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    
    // MARK: - Public Methods
    
    public func createCategoriesScreen(coordinator: MainCoordinator) -> UIViewController {
        CategoriesViewController(coordinator: coordinator)
    }
    
    public func createAPODScreenWith(coordinator: MainCoordinator, title: String) -> UIViewController {
        APODViewController(coordinator: coordinator, title: title)
    }
    
    public func createAsteroidsScreen(coordinator: MainCoordinator, title: String) -> UIViewController {
        AsteroidViewController(coordinator: coordinator, title: title)
    }
    
    public func createEPICScreen(coordinator: MainCoordinator, title: String) -> UIViewController {
        EPICViewController(coordinator: coordinator, title: title)
    }
    
    public func createMarsRoverScreen(coordinator: MainCoordinator, title: String) -> UIViewController {
        MarsRoverCollectionViewController(coordinator: coordinator, title: title)
    }
    
    public func createTabBarController(coordinator: MainCoordinator) -> UITabBarController {
        TabBarController(coordinator: coordinator)
    }
    
    func createFavoritesScreen(coordinator: MainCoordinator) -> UIViewController {
        FavoritesViewController(coordinator: coordinator)
    }
    
    func createMusicPlayerScreen(coordinator: MainCoordinator) -> UIViewController {
        MusicPlayerViewController(coordinator: coordinator)
    }
    
    public func createSingleImageScreen(
        coordinator: MainCoordinator,
        title: String,
        image: UIImage,
        url: String,
        isAPODVC: Bool,
        isEPICVC: Bool,
        isMarsRover: Bool,
        infoText: String
    ) -> UIViewController {
        SingleImageViewController(
            coordinator: coordinator,
            title: title,
            image: image,
            url: url,
            isAPODVC: isAPODVC,
            isEPICVC: isEPICVC,
            isMarsRover: isMarsRover,
            infoText: infoText
        )
    }
    
}
