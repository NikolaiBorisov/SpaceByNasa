//
//  AsteroidDTO.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 11.12.2021.
//

import UIKit

// MARK: - AsteroidDTO

struct AsteroidDTO: Codable {
    let links: AsteroidDTOLinks
    let page: Page
    let nearEarthObjects: [NearEarthObject]
    
    enum CodingKeys: String, CodingKey {
        case links, page
        case nearEarthObjects = "near_earth_objects"
    }
}

// MARK: - AsteroidDTOLinks

struct AsteroidDTOLinks: Codable {
    let next, linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case next
        case linksSelf = "self"
    }
}

// MARK: - NearEarthObject

struct NearEarthObject: Codable {
    let links: NearEarthObjectLinks
    let id, neoReferenceID, name, nameLimited: String
    let designation: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let orbitalData: OrbitalData
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nameLimited = "name_limited"
        case designation
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case orbitalData = "orbital_data"
        case isSentryObject = "is_sentry_object"
    }
}

// MARK: - CloseApproachDatum

struct CloseApproachDatum: Codable {
    let closeApproachDate, closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: OrbitingBody
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

// MARK: - MissDistance

struct MissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String
}

enum OrbitingBody: String, Codable {
    case earth = "Earth"
    case juptr = "Juptr"
    case mars = "Mars"
    case merc = "Merc"
    case venus = "Venus"
}

// MARK: - RelativeVelocity

struct RelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

// MARK: - EstimatedDiameter

struct EstimatedDiameter: Codable {
    let kilometers, meters, miles, feet: Feet
}

// MARK: - Feet

struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}

// MARK: - NearEarthObjectLinks

struct NearEarthObjectLinks: Codable {
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - OrbitalData

struct OrbitalData: Codable {
    let orbitID, orbitDeterminationDate, firstObservationDate, lastObservationDate: String
    let dataArcInDays, observationsUsed: Int
    let orbitUncertainty, minimumOrbitIntersection, jupiterTisserandInvariant, epochOsculation: String
    let eccentricity, semiMajorAxis, inclination, ascendingNodeLongitude: String
    let orbitalPeriod, perihelionDistance, perihelionArgument, aphelionDistance: String
    let perihelionTime, meanAnomaly, meanMotion: String
    let equinox: Equinox
    let orbitClass: OrbitClass
    
    enum CodingKeys: String, CodingKey {
        case orbitID = "orbit_id"
        case orbitDeterminationDate = "orbit_determination_date"
        case firstObservationDate = "first_observation_date"
        case lastObservationDate = "last_observation_date"
        case dataArcInDays = "data_arc_in_days"
        case observationsUsed = "observations_used"
        case orbitUncertainty = "orbit_uncertainty"
        case minimumOrbitIntersection = "minimum_orbit_intersection"
        case jupiterTisserandInvariant = "jupiter_tisserand_invariant"
        case epochOsculation = "epoch_osculation"
        case eccentricity
        case semiMajorAxis = "semi_major_axis"
        case inclination
        case ascendingNodeLongitude = "ascending_node_longitude"
        case orbitalPeriod = "orbital_period"
        case perihelionDistance = "perihelion_distance"
        case perihelionArgument = "perihelion_argument"
        case aphelionDistance = "aphelion_distance"
        case perihelionTime = "perihelion_time"
        case meanAnomaly = "mean_anomaly"
        case meanMotion = "mean_motion"
        case equinox
        case orbitClass = "orbit_class"
    }
}

enum Equinox: String, Codable {
    case j2000 = "J2000"
}

// MARK: - OrbitClass

struct OrbitClass: Codable {
    let orbitClassType: OrbitClassType
    let orbitClassDescription: String
    let orbitClassRange: OrbitClassRange
    
    enum CodingKeys: String, CodingKey {
        case orbitClassType = "orbit_class_type"
        case orbitClassDescription = "orbit_class_description"
        case orbitClassRange = "orbit_class_range"
    }
}

enum OrbitClassRange: String, Codable {
    case aSemiMajorAxis10AUQPerihelion1017AU = "a (semi-major axis) > 1.0 AU; q (perihelion) < 1.017 AU"
    case the1017AUQPerihelion13AU = "1.017 AU < q (perihelion) < 1.3 AU"
}

enum OrbitClassType: String, Codable {
    case amo = "AMO"
    case apo = "APO"
}

// MARK: - Page

struct Page: Codable {
    let size, totalElements, totalPages, number: Int
    
    enum CodingKeys: String, CodingKey {
        case size
        case totalElements = "total_elements"
        case totalPages = "total_pages"
        case number
    }
}
