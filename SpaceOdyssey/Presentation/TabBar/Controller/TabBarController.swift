//
//  TabBarController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import UIKit

/// Class displays custom TabBar
final class TabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    
    private lazy var centralTabBarButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "nasaLogoTabBar"), for: .normal)
        $0.isUserInteractionEnabled = false
        $0.layer.masksToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var customTabBarFrame: NasaTabBarView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(NasaTabBarView())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupView()
        setupTabBarItem()
        setupLayouts()
        selectedIndex = 1
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupCentralTabBarButton()
    }
    
    // MARK: - Initializers
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        centralTabBarButton.backgroundColor = .black
    }
    
    private func setupCentralTabBarButton() {
        centralTabBarButton.roundViewWith(
            cornerRadius: centralTabBarButton.frame.height / 2,
            borderColor: .black,
            borderWidth: 0
        )
    }
    
    private func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage? = nil
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    private func setupTabBarItem() {
        coordinator.start()
        
        guard let image1 = UIImage(systemName: "music.note.list"),
              let image2 = UIImage(systemName: "star") else { return }
        
        viewControllers = [
            createNavController(for: MusicPlayerViewController(), title: "Music", image: image1),
            createNavController(for: CategoriesViewController(coordinator: coordinator), title: "Categories", image: nil),
            createNavController(for: FavoritesViewController(), title: "Favorites", image: image2)
        ]
    }
    
    private func addSubviews() {
        view.addSubview(customTabBarFrame)
        tabBar.addSubview(centralTabBarButton)
        view.bringSubviewToFront(tabBar)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            centralTabBarButton.heightAnchor.constraint(equalToConstant: 40),
            centralTabBarButton.widthAnchor.constraint(equalToConstant: 45),
            centralTabBarButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centralTabBarButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10.0),
            
            customTabBarFrame.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            customTabBarFrame.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            customTabBarFrame.widthAnchor.constraint(equalTo: tabBar.widthAnchor),
            customTabBarFrame.heightAnchor.constraint(equalTo: tabBar.heightAnchor)
        ])
    }
    
}
