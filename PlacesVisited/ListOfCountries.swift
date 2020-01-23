//
//  ListOfCountries.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-23.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation

class ListOfCountries {
    private var countries = [Country]()
    
    //computed property
    var count:Int {
        return countries.count
    }
    
    func add(country: Country) {
        countries.append(country)
    }
    
    func showCountry(index: Int) -> Country? {
        
        if(index >= 0 && index < countries.count) {
            return countries[index]
        }
        return nil
    }
    

    
    
}
