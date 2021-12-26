//
//  UITabBarController+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 24.12.2021.
//

import UIKit

// MARK: - Create NavigationController

extension UITabBarController {
    func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage? = nil
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
