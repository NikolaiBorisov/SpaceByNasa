//
//  NasaCategoryFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class creates Categories for CategoriesViewController
final class NasaCategoryFactory {
    
    static func makeCategories() -> [Category] {
        let categories = [
            Category(title: "APOD", subTitle: "Astronomy Picture of the Day", image: "apodIcon"),
            Category(title: "Asteroids NeoWs", subTitle: "Near Earth Object Web Service", image: "asteroidIcon"),
            Category(title: "EPIC", subTitle: "Earth Polychromatic Imaging Camera", image: "epicIcon"),
            Category(title: "Mars Rover Photos", subTitle: "Photos gathered by NASA's Curiosity, Opportunity, and Spirit rovers on Mars", image: "marsIcon")
        ]
        return categories
    }
    
}
