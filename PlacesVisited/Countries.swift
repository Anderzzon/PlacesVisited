//
//  Countries.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-16.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation

class Countries {
    
    let shortName: String
    let fullName: String
    var visited = false
    
    init(short:String, name:String) {
        self.shortName = short
        self.fullName = name
    }
    
    
}
