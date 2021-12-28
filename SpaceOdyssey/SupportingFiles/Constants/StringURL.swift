//
//  StringURL.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 09.12.2021.
//

import UIKit

enum StringURL {
    
    // MARK: - NASA APIKey
    
    static let myAPIKey = "YDLcthwpCgRrHtlq98X6VBX8MGAKjcYY7AMMVyim"
    
    // MARK: - APODData URL
    
    static let apodURL = "https://api.nasa.gov/planetary/apod?api_key=\(myAPIKey)"
    
    // MARK: - EPICData URL
    
    static let epicURL = "https://api.nasa.gov/EPIC/api/natural?api_key=\(myAPIKey)"
    
    // MARK: - EPICImageURL
    
    static let epicURLImage = { (date: String, image: String) in
        "https://api.nasa.gov/EPIC/archive/natural/\(date)/png/\(image).png?api_key=\(myAPIKey)"
    }
    
    // MARK: - AsteroidURL
    
    static let asteroidURL = "https://api.nasa.gov/neo/rest/v1/neo/browse?api_key=\(myAPIKey)"
    
    // MARK: - AsteroidViewURL
    
    static let asteroidViewURL = { (id: String) in
        "https://ssd.jpl.nasa.gov/tools/sbdb_lookup.html#/?sstr=\(id)&view=VOP"
    }
    
    // MARK: - MarsRoverURL
    
    static let marsRoverURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=\(myAPIKey)"
    
    // MARK: - MusicURL
    
    static let interstellar1 = Bundle.main.url(
        forResource: AppMusic.stay,
        withExtension: AppMusic.mp3
    )
    
    static let interstellar2 = Bundle.main.url(
        forResource: AppMusic.mountains,
        withExtension: AppMusic.mp3
    )
    
    static let interstellar3 = Bundle.main.url(
        forResource: AppMusic.firstStep,
        withExtension: AppMusic.mp3
    )
    
}
