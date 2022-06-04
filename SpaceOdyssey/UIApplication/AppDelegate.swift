//
//  AppDelegate.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit
import CoreData

@main
@available (iOS 13, *)
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public Properties
    
    public var window: UIWindow?
    
    // MARK: - Private Properties
    
    private var tabBarAppearance = UITabBar.appearance()
    private var tabBarItemAppearance = UITabBarItem.appearance()
    
    // MARK: - Public Methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavBar()
        setupTabBar()
        print("Database FilePath:", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found")
        return true
    }
    
    // MARK: - Private Properties
    
    private func setupNavBar() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    private func setupTabBar() {
        tabBarAppearance.barTintColor = .black
        tabBarAppearance.tintColor = .white
        tabBarAppearance.backgroundColor = .black
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font: (UIFont.avenirNextMediumOfSize(10))], for: .normal)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}
