//
//  Countries.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-16.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation

class Country {
    
    let shortName: String
    let fullName: String
    let continent: String
    let flagIcon: Character
    var visited = false
    var wantToGo = false
    
    init(short:String, name:String, continent:String, flagIcon:Character) {
        self.shortName = short
        self.fullName = name
        self.continent = continent
        self.flagIcon = flagIcon
    }
    
    
}
