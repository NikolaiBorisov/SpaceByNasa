//
//  SceneDelegate.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

@available (iOS 13, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public Properties
    
    public var window: UIWindow?
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator = {
        let nc = UINavigationController()
        return MainCoordinatorImpl(navigationController: nc)
    }()
    
    // MARK: - Public Methods
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createInitialViewController()
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Private Methods
    
    private func createInitialViewController() -> UIViewController {
        return TabBarController(coordinator: coordinator)
    }
    
}
