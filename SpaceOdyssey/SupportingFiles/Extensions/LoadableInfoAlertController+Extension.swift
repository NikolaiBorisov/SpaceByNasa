//
//  LoadableInfoAlertController+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import UIKit

/// Protocol contains method for presenting InfoAlertController
protocol LoadableInfoAlertController {
    func showInfoAlertWith(
        title: String,
        message: String,
        completionOK: @escaping () -> Void?,
        completionCancel: @escaping () -> Void?
    )
}

// MARK: - Present LoadableInfoAlertController

extension LoadableInfoAlertController where Self: UIViewController {
    
    func showInfoAlertWith(
        title: String,
        message: String,
        completionOK: @escaping () -> Void?,
        completionCancel: @escaping () -> Void?
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let okButton = UIAlertAction(
                title: "Proceed",
                style: .default,
                handler: { _ in
                    completionOK()
                }
            )
            let cancelButton = UIAlertAction(
                title: "Cancel",
                style: .destructive,
                handler: { _ in
                    completionCancel()
                }
            )
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            alert.view.tintColor = .cyan
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
            
            alert.setValue(NSAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.avenirNextMediumOfSize(16),
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]), forKey: "attributedMessage")
            
            alert.setValue(NSAttributedString(
                string: title,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan]
            ), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
