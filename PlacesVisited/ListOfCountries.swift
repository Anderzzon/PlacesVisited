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
        case Europe, Asia, NorthAmerica, Africa, SouthAmerica, Oceania
    }
    
    private var countriesInEurope: [Country] = []
    private var countriesInAsia: [Country] = []
    private var countriesInNorthAmerica: [Country] = []
    private var countriesInAfrica: [Country] = []
    private var countriesInSouthAmerica: [Country] = []
    private var countriesInOceania: [Country] = []
    
    
    var totalNumberOfCountries:Int {
        var numberOfCountries = 0
        numberOfCountries += countriesInAsia.count
        numberOfCountries += countriesInAfrica.count
        numberOfCountries += countriesInNorthAmerica.count
        numberOfCountries += countriesInEurope.count
        numberOfCountries += countriesInSouthAmerica.count
        numberOfCountries += countriesInOceania.count
        
        return numberOfCountries
    }
    
    var numberOfCountriesVisited:Int {
        var numberOfCountriesVisited = 0
        for i in 0..<countriesInAsia.count {
            if countriesInAsia[i].visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for i in 0..<countriesInAfrica.count {
            if countriesInAfrica[i].visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for i in 0..<countriesInNorthAmerica.count {
            if countriesInNorthAmerica[i].visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for i in 0..<countriesInEurope.count {
            if countriesInEurope[i].visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for i in 0..<countriesInSouthAmerica.count {
            if countriesInSouthAmerica[i].visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for i in 0..<countriesInOceania.count {
            if countriesInOceania[i].visited == true {
                numberOfCountriesVisited += 1
            }
        }
        return numberOfCountriesVisited
    }

    var numberOfCountriesWantToGoTo:Int {
        var numberOfCountriesWantToGoTo = 0
        for i in 0..<countriesInAsia.count {
            if countriesInAsia[i].wantToGo == true && countriesInAsia[i].visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for i in 0..<countriesInAfrica.count {
            if countriesInAfrica[i].wantToGo == true && countriesInAfrica[i].visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for i in 0..<countriesInNorthAmerica.count {
            if countriesInNorthAmerica[i].wantToGo == true && countriesInNorthAmerica[i].visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for i in 0..<countriesInEurope.count {
            if countriesInEurope[i].wantToGo == true && countriesInEurope[i].visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for i in 0..<countriesInSouthAmerica.count {
            if countriesInSouthAmerica[i].wantToGo == true && countriesInSouthAmerica[i].visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for i in 0..<countriesInOceania.count {
            if countriesInOceania[i].wantToGo == true && countriesInOceania[i].visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        return numberOfCountriesWantToGoTo
    }
    
    //This functions is currently not used:
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
        for i in 0..<countriesInSouthAmerica.count {
            if countriesInSouthAmerica[i].visited == false {
                numberOfCountriesNotVisited += 1
            }
        }
        for i in 0..<countriesInOceania.count {
            if countriesInOceania[i].visited == false {
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
        case .SouthAmerica:
            countriesInSouthAmerica.append(country)
        case .Oceania:
            countriesInOceania.append(country)
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
        case .SouthAmerica:
            return countriesInSouthAmerica
        case .Oceania:
            return countriesInOceania
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
        case .SouthAmerica:
            for i in 0..<countriesInSouthAmerica.count {
                if countriesInSouthAmerica[i].visited == false {
                    countriesNotVisited.append(countriesInSouthAmerica[i])
                }
            }
            return countriesNotVisited
        case .Oceania:
            for i in 0..<countriesInOceania.count {
                if countriesInOceania[i].visited == false {
                    countriesNotVisited.append(countriesInOceania[i])
                }
            }
        return countriesNotVisited
        }
    }
    
    //Computes percentage of world visited
    func percentOfWorldVisited() -> Double {
        var percent:Double
        
        percent = Double(numberOfCountriesVisited) / Double((numberOfCountriesVisited + numberOfCountriesNotVisited))
        percent = percent*100
        percent = Double(round(10*percent)/10)
        
        print("You have visited \(percent) % of the world")
        
        return percent
    }
    
    func percentOfContinentVisited(for continent: Continents) -> Double {
        var visited = 0
        var percent:Double
        
        switch continent {
        case .Africa:
            for i in 0..<countriesInAfrica.count {
                if countriesInAfrica[i].visited == true {
                visited += 1
                }
            }
            percent = Double(visited) / Double((countriesInAfrica.count))
            percent = percent*100
            percent = Double(round(10*percent)/10)
            return percent
        case .Asia:
            for i in 0..<countriesInAsia.count {
                if countriesInAsia[i].visited == true {
                visited += 1
                }
            }
            percent = Double(visited) / Double((countriesInAsia.count))
            percent = percent*100
            percent = Double(round(10*percent)/10)
            return percent
        case .Europe:
            for i in 0..<countriesInEurope.count {
                if countriesInEurope[i].visited == true {
                visited += 1
                }
            }
            percent = Double(visited) / Double((countriesInEurope.count))
            percent = percent*100
            percent = Double(round(10*percent)/10)
            return percent
        case .NorthAmerica:
            for i in 0..<countriesInNorthAmerica.count {
                if countriesInNorthAmerica[i].visited == true {
                visited += 1
                }
            }
            percent = Double(visited) / Double((countriesInNorthAmerica.count))
            percent = percent*100
            percent = Double(round(10*percent)/10)
            return percent
        case .SouthAmerica:
            for i in 0..<countriesInSouthAmerica.count {
                if countriesInSouthAmerica[i].visited == true {
                visited += 1
                }
            }
            percent = Double(visited) / Double((countriesInSouthAmerica.count))
            percent = percent*100
            percent = Double(round(10*percent)/10)
            return percent
        case .Oceania:
            for i in 0..<countriesInOceania.count {
                if countriesInOceania[i].visited == true {
                visited += 1
                }
            }
            percent = Double(visited) / Double((countriesInOceania.count))
            percent = percent*100
            percent = Double(round(10*percent)/10)
            return percent
        }
    }
    
    func bucketListProgress() -> Double {
        var percent:Double
        
        percent = Double(numberOfCountriesVisited) / Double((numberOfCountriesVisited + numberOfCountriesWantToGoTo))
        percent = percent*100
        percent = Double(round(10*percent)/10)
        print("You are \(percent) % on progress of your goal")
        
        return percent
    }
    
}
