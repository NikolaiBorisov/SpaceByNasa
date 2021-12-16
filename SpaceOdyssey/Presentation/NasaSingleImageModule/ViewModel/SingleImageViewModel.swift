//
//  SingleImageViewModel.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class provides viewModel for SingleImageViewController
final class SingleImageViewModel {
    
    // MARK: - Public Properties
    
    public var singleImage = UIImage()
    public var navBarTitle = ""
    public var hdURL = ""
    public var isAPODVC: Bool?
    public var isEPICVC: Bool?
    public var isMarsRover: Bool?
    
    // MARK: - Public Methods
    
    public func createActivityViewControllerWith(item: Any, on view: UIViewController) {
        let shareController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        view.present(shareController, animated: true, completion: nil)
    }
    
    public func openSite(urlString: String) {
        let appShared = UIApplication.shared
        guard let url = URL(string: urlString),
              appShared.canOpenURL(url) else { return }
        appShared.open(url, options: [:], completionHandler: nil)
    }
    
}
