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
    
    
    var totalNumberOfCountries:Int {
        var numberOfCountries = 0
        numberOfCountries += countriesInAsia.count
        numberOfCountries += countriesInAfrica.count
        numberOfCountries += countriesInNorthAmerica.count
        numberOfCountries += countriesInEurope.count
        
        return numberOfCountries
    }
    
    var numberOfCountriesNotVisited:Int {
        var numberOfCountriesNotVisited = 0
        for i in 0..<countriesInAsia.count {
            if countriesInAsia[i].visited == false {
                numberOfCountriesNotVisited += 1
            }
        }
        for i in 0..<countriesInAfrica.count {
            if countriesInAfrica[i].visited == false {
                numberOfCountriesNotVisited += 1
            }
        }
        for i in 0..<countriesInNorthAmerica.count {
            if countriesInNorthAmerica[i].visited == false {
                numberOfCountriesNotVisited += 1
            }
        }
        for i in 0..<countriesInEurope.count {
            if countriesInEurope[i].visited == false {
                numberOfCountriesNotVisited += 1
            }
        }
        return numberOfCountriesNotVisited
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
    
    func listOfCountriesNotVisited(for continent: Continents) -> [Country] {
        var countriesNotVisited: [Country] = []
        switch continent {
        case .Africa:
            for i in 0..<countriesInAfrica.count {
                if countriesInAfrica[i].visited == false {
                    countriesNotVisited.append(countriesInAfrica[i])
                }
            }
            return countriesNotVisited
        case .Asia:
            for i in 0..<countriesInAsia.count {
                if countriesInAsia[i].visited == false {
                    countriesNotVisited.append(countriesInAsia[i])
                }
            }
            return countriesNotVisited
        case .Europe:
            for i in 0..<countriesInEurope.count {
                if countriesInEurope[i].visited == false {
                    countriesNotVisited.append(countriesInEurope[i])
                }
            }
            return countriesNotVisited
        case .NorthAmerica:
            for i in 0..<countriesInNorthAmerica.count {
                if countriesInNorthAmerica[i].visited == false {
                    countriesNotVisited.append(countriesInNorthAmerica[i])
                }
            }
            return countriesNotVisited
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
