//
//  LoadableErrorAlertController+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.12.2021.
//

import UIKit

/// Protocol contains method for presenting ErrorAlertController
protocol LoadableErrorAlertController {
    func showErrorAlertWith(title: String, message: AppError, completion: @escaping () -> Void?)
}

// MARK: - Present LoadableErrorAlertController

extension LoadableErrorAlertController where Self: UIViewController {
    
    func showErrorAlertWith(title: String, message: AppError, completion: @escaping () -> Void?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message.title,
                preferredStyle: .alert
            )
            let resetData = UIAlertAction(
                title: "Reload",
                style: .default,
                handler: { _ in
                    completion()
                }
            )
            let cancel = UIAlertAction(
                title: "Cancel",
                style: .destructive,
                handler: { _ in
                    completion()
                }
            )
            alert.addAction(resetData)
            alert.addAction(cancel)
            alert.view.tintColor = .cyan
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
            
            alert.setValue(NSAttributedString(
                string: title,
                attributes: [
                    NSAttributedString.Key.font: UIFont.avenirNextMediumOfSize(16),
                    NSAttributedString.Key.foregroundColor : UIColor.cyan
                ]), forKey: "attributedTitle")
            alert.setValue(NSAttributedString(
                string: message.title,
                attributes: [
                    NSAttributedString.Key.font: UIFont.avenirNextMediumOfSize(16),
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]), forKey: "attributedMessage")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
