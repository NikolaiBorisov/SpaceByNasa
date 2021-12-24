//
//  APODViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class provides viewModel for APODViewController
final class APODViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = APODView()
    public var dataFetcherService = DataFetcherService()
    public var apodData: ApodDTO?
    public var navBarTitle = ""
    
    // MARK: - Public Methods
    
    public func getData(completion: @escaping (AppError) -> Void?) {
        mainView.activityIndicator.startAnimating()
        dataFetcherService.fetchAPODData { [weak self] result in
            switch result {
            case .failure(let error):
                completion(error)
                print(error)
            case .success(let apodData):
                guard let self = self else { return }
                self.apodData = apodData
                self.mainView.apodTableView.alpha = 1
                self.mainView.apodTableView.reloadData()
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
    
}
