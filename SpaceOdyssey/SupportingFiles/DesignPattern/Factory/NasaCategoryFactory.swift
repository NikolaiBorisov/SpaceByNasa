//
//  NasaCategoryFactory.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

/// Class creates Categories for CategoriesViewController
final class NasaCategoryFactory {
    
    static func makeCategories() -> [NasaCategoriesModel] {
        let categories = [
            NasaCategoriesModel(title: "APOD", subTitle: "Astronomy Picture of the Day"),
            NasaCategoriesModel(title: "Asteroids NeoWs", subTitle: "Near Earth Object Web Service"),
            NasaCategoriesModel(title: "EPIC", subTitle: "Earth Polychromatic Imaging Camera"),
            NasaCategoriesModel(title: "Mars Rover Photos", subTitle: "Photos gathered by NASA's Curiosity, Opportunity, and Spirit rovers on Mars")
        ]
        return categories
    }
    
}
