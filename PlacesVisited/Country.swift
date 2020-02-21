//
//  Countries.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-16.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation
import CoreData

@objc(Country)
class Country: NSManagedObject {
    
    @NSManaged var shortName: String
    @NSManaged var fullName: String
    @NSManaged var continent: String
    @NSManaged var flagIcon: String
    @NSManaged var visited: Bool
    @NSManaged var wantToGo: Bool
    
    //Sets a country to visited or reverse that
    func visitCountry(visit: Bool ) {
        visited = visit
    }
    
    func toggleVisited() {
         visited = !visited
    }
    
    func toggleWantToGo() {
        if self.wantToGo == false {
            wantToGo = true
        } else if self.wantToGo == true {
            wantToGo = false
        }
    }
    
}
