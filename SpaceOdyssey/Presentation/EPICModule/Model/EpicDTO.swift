//
//  EpicDTO.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

// MARK: - EpicDTO

struct EpicDTO: Codable {
    let identifier: String
    let caption: String
    let image: String
    let version: String
    let centroidCoordinates: CentroidCoordinates
    let dscovrJ2000Position: J2000Position
    let lunarJ2000Position: J2000Position
    let sunJ2000Position: J2000Position
    let attitudeQuaternions: AttitudeQuaternions
    let date: String
    let coords: Coords
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case caption
        case image
        case version
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
        case date
        case coords
    }
}

// MARK: - AttitudeQuaternions

struct AttitudeQuaternions: Codable {
    let q0: Double
    let q1: Double
    let q2: Double
    let q3: Double
}

// MARK: - CentroidCoordinates

struct CentroidCoordinates: Codable {
    let lat: Double
    let lon: Double
}

// MARK: - Coords

struct Coords: Codable {
    let centroidCoordinates: CentroidCoordinates
    let dscovrJ2000Position: J2000Position
    let lunarJ2000Position: J2000Position
    let sunJ2000Position: J2000Position
    let attitudeQuaternions: AttitudeQuaternions
    
    enum CodingKeys: String, CodingKey {
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
    }
}

// MARK: - J2000Position

struct J2000Position: Codable {
    let x: Double
    let y: Double
    let z: Double
}
