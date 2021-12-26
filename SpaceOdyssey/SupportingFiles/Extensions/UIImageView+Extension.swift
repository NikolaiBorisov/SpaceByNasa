//
//  UIImageView+Extension.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 24.12.2021.
//

import UIKit

extension UIImageView {
    func setupImageFor(
        view: UIImageView,
        service: ImageCachingService,
        url: String,
        completion: @escaping () -> Void
    ) {
        guard let imgURL = URL(string: url) else { return }
        service.getImageWith(url: imgURL) { image in
            view.image = image
            completion()
        }
    }
}
