//
//  EPICViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class provides viewModel for EPICViewController
final class EPICViewModel {
    
    // MARK: - Public Properties
    
    public lazy var mainView = EPICView()
    public var dataFetcherService = DataFetcherService()
    public var epicData: [EpicDTO] = []
    public var epicData1: EpicDTO?
    public var navBarTitle = ""
    public var isFirstLoaded = true
    
    // MARK: - Public Methods
    
    public func getData(completion: @escaping (AppError) -> Void?) {
        mainView.activityIndicator.startAnimating()
        dataFetcherService.fetchEPICData { [weak self] result in
            switch result {
            case .failure(let error):
                completion(error)
                print(error)
            case .success(let epicData):
                guard let self = self else { return }
                self.epicData = epicData ?? []
                self.epicData1 = epicData?.first
                self.mainView.epicTableView.alpha = 1
                self.mainView.epicTableView.reloadData()
                self.mainView.activityIndicator.stopAnimating()
                self.mainView.tableRefreshControl.endRefreshing()
            }
        }
    }
    
    public func setupCallback(completion: @escaping (AppError) -> Void?) {
        mainView.refreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.isFirstLoaded = false
            self.getData(completion: completion)
        }
    }
    
}
