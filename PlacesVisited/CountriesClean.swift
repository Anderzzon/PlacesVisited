//
//  CountriesClean.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-02-13.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation






struct Name: Codable {
    let ADMIN: String
}

//struct Coordinates: Codable {
//    let coordinates: [CoordinatesPolygons]
//}

struct CountriesClean: Codable {
    let properties: Name
//    let geometry: Coordinates
    
}


