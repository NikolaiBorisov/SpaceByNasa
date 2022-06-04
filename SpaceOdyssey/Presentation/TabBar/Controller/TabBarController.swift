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
        $0.setBackgroundImage(AppImage.tabBarCentralButton, for: .normal)
        $0.layer.masksToBounds = true
        $0.backgroundColor = .black
        return $0
    }(UIButton(type: .system))
    
    private lazy var customTabBarFrame: NasaTabBarView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(NasaTabBarView())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCoordinator()
        addSubviews()
        setupTabBarItem()
        setupLayouts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupCentralTabBarButton()
    }
    
    // MARK: - Initializers
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        setSelectedIndex()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCentralTabBarButton() {
        centralTabBarButton.roundViewWith(cornerRadius: centralTabBarButton.frame.height / 2)
    }
    
    private func setSelectedIndex() {
        selectedIndex = 1
    }
    
    private func startCoordinator() {
        coordinator.start()
    }
    
    private func setupTabBarItem() {
        guard let musicVCImg = AppImage.musicVCItem,
              let favoritesVCImg = AppImage.favoritesVCItem else { return }
        
        let musicVC = createNavController(
            for: MusicPlayerViewController(coordinator: coordinator),
               title: Localization.musicVCTitle,
               image: musicVCImg
        )
        let categoriesVC = coordinator.navigationController
        let favoritesVC = createNavController(
            for: FavoritesViewController(coordinator: coordinator),
               title: Localization.favoritesVCTitle,
               image: favoritesVCImg
        )
        viewControllers = [musicVC, categoriesVC, favoritesVC]
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
