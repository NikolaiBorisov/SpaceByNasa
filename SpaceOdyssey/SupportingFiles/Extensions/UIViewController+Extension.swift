//
//  UIViewController+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 15.12.2021.
//

import UIKit

// MARK: - Custom NavBar

extension UIViewController {
    func setupNavBarWith(title: String? = nil, font: UIFont? = UIFont.avenirNextDemiBoldOfSize(35)) {
        let appearance = UINavigationBarAppearance()
        guard let navBar = navigationController?.navigationBar else { return }
        self.title = title
        navigationItem.backButtonTitle = ""
        
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: font ?? .systemFont(ofSize: 35)
        ]
        appearance.backgroundImage = AppImage.moon
        
        navBar.tintColor = .white
        navBar.standardAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.prefersLargeTitles = true
    }
}

// MARK: - Create RightBarButtonItem

extension UIViewController {
    func setupRightNavItem(
        _ target: Any,
        action: Selector,
        title: String? = nil,
        icon: UIImage? = nil
    ) -> UIBarButtonItem {
        let rightBarButtonItem = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: target,
            action: action
        )
        rightBarButtonItem.tintColor = .white
        rightBarButtonItem.title = title
        return rightBarButtonItem
    }
}
