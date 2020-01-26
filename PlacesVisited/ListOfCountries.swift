//
//  ListOfCountries.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-23.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation

class ListOfCountries {
    
    enum Continents: Int, CaseIterable {
        case Europe, Asia, NorthAmerica, Africa
    }
    
    private var countriesInEurope: [Country] = []
    private var countriesInAsia: [Country] = []
    private var countriesInNorthAmerica: [Country] = []
    private var countriesInAfrica: [Country] = []
    
    //var countries = [Country]()
    
    //computed property
    var count:Int {
        var countEnum = 0
        countEnum += countriesInAsia.count
        countEnum += countriesInAfrica.count
        countEnum += countriesInNorthAmerica.count
        countEnum += countriesInEurope.count
        
        return countEnum
    }
    
    func add(country: Country, for continent: Continents) {
        //countries.append(country)
        switch continent {
        case .Africa:
            countriesInAfrica.append(country)
        case .Asia:
            countriesInAsia.append(country)
        case .Europe:
            countriesInEurope.append(country)
        case .NorthAmerica:
            countriesInNorthAmerica.append(country)
        }
    }
    
    func listOfCountries(for continent: Continents) -> [Country] {
        switch continent {
        case .Africa:
            return countriesInAfrica
        case .Asia:
            return countriesInAsia
        case .Europe:
            return countriesInEurope
        case .NorthAmerica:
            return countriesInNorthAmerica
        }
    }
    
//    func showCountry(index: Int) -> Country? {
//
//        if(index >= 0 && index < countries.count) {
//            return countries[index]
//        }
//        return nil
//    }
    
    //Sets a country to visited or reverse that
//    func visitCountry(index: Int, visit: Bool ) {
//        countries[index].visited = visit
//    }
    
    
}
