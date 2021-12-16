//
//  AsteroidViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.12.2021.
//

import UIKit

/// Class provides viewModel for AsteroidViewController
final class AsteroidViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = AsteroidView()
    public var dataFetcherService = DataFetcherService()
    public var asteroidData: AsteroidDTO?
    public var navBarTitle = ""
    
    // MARK: - Public Methods
    
    public func getData(completion: @escaping (AppError) -> Void?) {
        mainView.activityIndicator.startAnimating()
        dataFetcherService.fetchAsteroidData { [weak self] result in
            switch result {
            case .failure(let error):
                completion(error)
                print(error)
            case .success(let asteroidData):
                guard let self = self else { return }
                self.asteroidData = asteroidData
                self.mainView.asteroidTableView.reloadData()
                self.mainView.activityIndicator.stopAnimating()
                self.mainView.tableRefreshControl.endRefreshing()
            }
        }
    }
    
    public func setupCallback(completion: @escaping (AppError) -> Void?) {
        mainView.refreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.getData(completion: completion)
        }
    }
    
    public func openSite(urlString: String) {
        let appShared = UIApplication.shared
        guard let url = URL(string: urlString),
              appShared.canOpenURL(url) else { return }
        appShared.open(url, options: [:], completionHandler: nil)
    }
    
}
