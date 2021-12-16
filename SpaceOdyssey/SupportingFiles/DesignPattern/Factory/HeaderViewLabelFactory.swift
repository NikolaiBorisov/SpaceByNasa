//
//  HeaderViewLabelFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class creates headerLabel for UITableView
final class HeaderViewLabelFactory {
    
    static func generateLabelOn(view: UIView, withText: String) -> UILabel {
        let headerLabel = UILabel(frame: CGRect(x: 0, y: -5, width: view.frame.width, height: 30.0))
        headerLabel.text = withText
        headerLabel.textAlignment = .center
        headerLabel.textColor = .cyan
        headerLabel.font = .avenirNextMediumOfSize(21)
        return headerLabel
    }
    
}
