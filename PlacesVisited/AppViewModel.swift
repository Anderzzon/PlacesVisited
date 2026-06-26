//
//  AppViewModel.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-23.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation
import CoreData
import Combine

// Shared controller for all three screens. Holds country state and handles
// all mutations (visit, want-to-go). Injected as @EnvironmentObject from PlacesVisitedApp.
class AppViewModel: ObservableObject {

    // Received from PersistenceController — used to fetch and save Country records
    var managedContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        managedContext = context
    }

    enum Continents: Int, CaseIterable {
        case Europe, Asia, NorthAmerica, Africa, SouthAmerica, Oceania
    }

    // Publishing per-continent arrays so views re-render when any country changes
    @Published private var countriesInEurope: [Country] = []
    @Published private var countriesInAsia: [Country] = []
    @Published private var countriesInNorthAmerica: [Country] = []
    @Published private var countriesInAfrica: [Country] = []
    @Published private var countriesInSouthAmerica: [Country] = []
    @Published private var countriesInOceania: [Country] = []
    
    func createCountry(fullName:String, shortName:String, continent:String, flagIcon:String) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Country", in: managedContext) else {return}
        
        let country = Country(entity: entity, insertInto: managedContext)
        
        country.fullName = fullName
        country.shortName = shortName
        country.continent = continent
        country.flagIcon = flagIcon
        country.visited = false
        country.wantToGo = false
        country.updateMap = false
        
        do {
            try managedContext.save()
            switch country.continent {
            case "Europe":
                countriesInEurope.append(country)
                //print("Adding country to Europe")
            case "Asia":
                countriesInAsia.append(country)
                //print("Adding country to Asia")
            case "Africa":
                countriesInAfrica.append(country)
                //print("Adding country to Africa")
            case "North America":
                countriesInNorthAmerica.append(country)
                //print("Adding country to North America")
            case "South America":
                countriesInSouthAmerica.append(country)
                //print("Adding country to South America")
            case "Oceania":
                countriesInOceania.append(country)
                //print("Adding country to Oceania")
            default:
                countriesInAsia.append(country)
                //print("appending country to default")
            }
        } catch let error as NSError {
            print("Save error \(error)")
        }
    }
    
    func deleteData() {
        let fetchRequest = NSFetchRequest<Country>(entityName: "Country")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
                try managedContext.save()
                
            }
        } catch let error as NSError {
            print("Detele all my data in, error : \(error) \(error.userInfo)")
        }
    }
    
    func loadItems() {
        
        let sortDescriptor = NSSortDescriptor(key: "fullName", ascending: true)
        
        let fetchAsia = NSFetchRequest<Country>(entityName: "Country")
        fetchAsia.sortDescriptors = [sortDescriptor]
        fetchAsia.predicate = NSPredicate(format: "continent == %@", "Asia")
        
        let fetchEurope = NSFetchRequest<Country>(entityName: "Country")
        fetchEurope.sortDescriptors = [sortDescriptor]
        fetchEurope.predicate = NSPredicate(format: "continent == %@", "Europe")
        
        let fetchAfrica = NSFetchRequest<Country>(entityName: "Country")
        fetchAfrica.sortDescriptors = [sortDescriptor]
        fetchAfrica.predicate = NSPredicate(format: "continent == %@", "Africa")
        
        let fetchNorthAmerica = NSFetchRequest<Country>(entityName: "Country")
        fetchNorthAmerica.sortDescriptors = [sortDescriptor]
        fetchNorthAmerica.predicate = NSPredicate(format: "continent == %@", "North America")
        
        let fetchSouthAmerica = NSFetchRequest<Country>(entityName: "Country")
        fetchSouthAmerica.sortDescriptors = [sortDescriptor]
        fetchSouthAmerica.predicate = NSPredicate(format: "continent == %@", "South America")
        
        let fetchOceania = NSFetchRequest<Country>(entityName: "Country")
        fetchOceania.sortDescriptors = [sortDescriptor]
        fetchOceania.predicate = NSPredicate(format: "continent == %@", "Oceania")
        
        //let fetchALL = NSFetchRequest<Country>(entityName: "Country")
        
        do {
            countriesInAsia = try managedContext.fetch(fetchAsia)
            countriesInEurope = try managedContext.fetch(fetchEurope)
            countriesInAfrica = try managedContext.fetch(fetchAfrica)
            countriesInNorthAmerica = try managedContext.fetch(fetchNorthAmerica)
            countriesInSouthAmerica = try managedContext.fetch(fetchSouthAmerica)
            countriesInOceania = try managedContext.fetch(fetchOceania)
            
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func updateVisit(country: Country, index: Int?) {
        let fetchRequest:NSFetchRequest<Country> = NSFetchRequest.init(entityName: "Country")
        fetchRequest.predicate = NSPredicate(format: "fullName = %@", "\(country.fullName)")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            
            if country.visited == false {
                objectUpdate.setValue(true, forKey: "visited")
                //print("Cuntry visit updated to TRUE")
            } else {
                objectUpdate.setValue(false, forKey: "visited")
                //print("Cuntry visit updated to FALSE")
            }
            do {
                try managedContext.save()
                //print("Visited saved!")
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
    
    
    func updateWantToGo(country: Country, index: Int?) {
        let fetchRequest:NSFetchRequest<Country> = NSFetchRequest.init(entityName: "Country")
        fetchRequest.predicate = NSPredicate(format: "fullName = %@", "\(country.fullName)")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            
            if country.wantToGo == false {
                objectUpdate.setValue(true, forKey: "wantToGo")
                //print("Cuntry want to go updated to TRUE")
            } else {
                objectUpdate.setValue(false, forKey: "wantToGo")
                //print("Cuntry want to go updated to FALSE")
            }
            do {
                try managedContext.save()
                //print("Want to go saved!")
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
    
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
        
        for country in countriesInAsia {
            if country.visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for country in countriesInAfrica {
            if country.visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for country in countriesInNorthAmerica {
            if country.visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for country in countriesInEurope {
            if country.visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for country in countriesInSouthAmerica {
            if country.visited == true {
                numberOfCountriesVisited += 1
            }
        }
        for country in countriesInOceania {
            if country.visited == true {
                numberOfCountriesVisited += 1
            }
        }
        return numberOfCountriesVisited
    }
    
    var numberOfCountriesWantToGoTo:Int {
        var numberOfCountriesWantToGoTo = 0
        for country in countriesInAsia {
            if country.wantToGo == true && country.visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for country in countriesInAfrica {
            if country.wantToGo == true && country.visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for country in countriesInNorthAmerica {
            if country.wantToGo == true && country.visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for country in countriesInEurope {
            if country.wantToGo == true && country.visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for country in countriesInSouthAmerica {
            if country.wantToGo == true && country.visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        for country in countriesInOceania {
            if country.wantToGo == true && country.visited == false {
                numberOfCountriesWantToGoTo += 1
            }
        }
        return numberOfCountriesWantToGoTo
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
            for country in countriesInAfrica {
                if country.visited == false {
                    countriesNotVisited.append(country)
                }
            }
            return countriesNotVisited
        case .Asia:
            for country in countriesInAsia {
                if country.visited == false {
                    countriesNotVisited.append(country)
                }
            }
            return countriesNotVisited
        case .Europe:
            for country in countriesInEurope {
                if country.visited == false {
                    countriesNotVisited.append(country)
                }
            }
            return countriesNotVisited
        case .NorthAmerica:
            for country in countriesInNorthAmerica {
                if country.visited == false {
                    countriesNotVisited.append(country)
                }
            }
            return countriesNotVisited
        case .SouthAmerica:
            for country in countriesInSouthAmerica {
                if country.visited == false {
                    countriesNotVisited.append(country)
                }
            }
            return countriesNotVisited
        case .Oceania:
            for country in countriesInOceania {
                if country.visited == false {
                    countriesNotVisited.append(country)
                }
            }
            return countriesNotVisited
        }
    }
    
    func listOfCountriesToUpdate(for continent: Continents) -> [Country] {
        var countriesToUpdate: [Country] = []
        switch continent {
        case .Africa:
            for country in countriesInAfrica {
                if country.updateMap == true {
                    countriesToUpdate.append(country)
                }
            }
            return countriesToUpdate
        case .Asia:
            for country in countriesInAsia {
                if country.updateMap == true {
                    countriesToUpdate.append(country)
                }
            }
            return countriesToUpdate
        case .Europe:
            for country in countriesInEurope {
                if country.updateMap == true {
                    countriesToUpdate.append(country)
                }
            }
            return countriesToUpdate
        case .NorthAmerica:
            for country in countriesInNorthAmerica {
                if country.updateMap == true {
                    countriesToUpdate.append(country)
                }
            }
            return countriesToUpdate
        case .SouthAmerica:
            for country in countriesInSouthAmerica {
                if country.updateMap == true {
                    countriesToUpdate.append(country)
                }
            }
            return countriesToUpdate
        case .Oceania:
            for country in countriesInOceania {
                if country.updateMap == true {
                    countriesToUpdate.append(country)
                }
            }
            return countriesToUpdate
        }
    }
    
    //Computes percentage of world visited
    func percentOfWorldVisited() -> Double {
        var percent:Double
        
        percent = Double(numberOfCountriesVisited) / Double((totalNumberOfCountries))
        percent = percent*100
        percent = Double(round(10*percent)/10)
        
        print("You have visited \(percent) % of the world")
        
        return percent
    }
    
    func bucketListProgress() -> Double {
        let total = numberOfCountriesVisited + numberOfCountriesWantToGoTo
        guard total > 0 else { return 0 }
        var percent = Double(numberOfCountriesVisited) / Double(total)
        percent = percent * 100
        percent = Double(round(10 * percent) / 10)
        return percent
    }

    func seedDatabase() {
        // Europe
        createCountry(fullName: "Albania", shortName: "ALB", continent: "Europe", flagIcon: "🇦🇱")
        createCountry(fullName: "Andorra", shortName: "AND", continent: "Europe", flagIcon: "🇦🇩")
        createCountry(fullName: "Austria", shortName: "AUT", continent: "Europe", flagIcon: "🇦🇹")
        createCountry(fullName: "Belarus", shortName: "BLR", continent: "Europe", flagIcon: "🇧🇾")
        createCountry(fullName: "Belgium", shortName: "BEL", continent: "Europe", flagIcon: "🇧🇪")
        createCountry(fullName: "Bosnia and Herzegovina", shortName: "BIH", continent: "Europe", flagIcon: "🇧🇦")
        createCountry(fullName: "Bulgaria", shortName: "BGR", continent: "Europe", flagIcon: "🇧🇬")
        createCountry(fullName: "Croatia", shortName: "HRV", continent: "Europe", flagIcon: "🇭🇷")
        createCountry(fullName: "Cyprus", shortName: "CYP", continent: "Europe", flagIcon: "🇨🇾")
        createCountry(fullName: "Czechia", shortName: "CZE", continent: "Europe", flagIcon: "🇨🇿")
        createCountry(fullName: "Denmark", shortName: "DNK", continent: "Europe", flagIcon: "🇩🇰")
        createCountry(fullName: "Estonia", shortName: "EST", continent: "Europe", flagIcon: "🇪🇪")
        createCountry(fullName: "Finland", shortName: "FIN", continent: "Europe", flagIcon: "🇫🇮")
        createCountry(fullName: "France", shortName: "FRA", continent: "Europe", flagIcon: "🇫🇷")
        createCountry(fullName: "Germany", shortName: "DEU", continent: "Europe", flagIcon: "🇩🇪")
        createCountry(fullName: "Greece", shortName: "GRC", continent: "Europe", flagIcon: "🇬🇷")
        createCountry(fullName: "Hungary", shortName: "HUN", continent: "Europe", flagIcon: "🇭🇺")
        createCountry(fullName: "Iceland", shortName: "ISL", continent: "Europe", flagIcon: "🇮🇸")
        createCountry(fullName: "Ireland", shortName: "IRL", continent: "Europe", flagIcon: "🇮🇪")
        createCountry(fullName: "Italy", shortName: "ITA", continent: "Europe", flagIcon: "🇮🇹")
        createCountry(fullName: "Kosovo", shortName: "RKS", continent: "Europe", flagIcon: "🇽🇰")
        createCountry(fullName: "Latvia", shortName: "LVA", continent: "Europe", flagIcon: "🇱🇻")
        createCountry(fullName: "Liechtenstein", shortName: "LIE", continent: "Europe", flagIcon: "🇱🇮")
        createCountry(fullName: "Lithuania", shortName: "LTU", continent: "Europe", flagIcon: "🇱🇹")
        createCountry(fullName: "Luxembourg", shortName: "LUX", continent: "Europe", flagIcon: "🇱🇺")
        createCountry(fullName: "Malta", shortName: "MLT", continent: "Europe", flagIcon: "🇲🇹")
        createCountry(fullName: "Moldova", shortName: "MDA", continent: "Europe", flagIcon: "🇲🇩")
        createCountry(fullName: "Monaco", shortName: "MCO", continent: "Europe", flagIcon: "🇲🇨")
        createCountry(fullName: "Montenegro", shortName: "MNE", continent: "Europe", flagIcon: "🇲🇪")
        createCountry(fullName: "Netherlands", shortName: "NLD", continent: "Europe", flagIcon: "🇳🇱")
        createCountry(fullName: "North Macedonia", shortName: "MKD", continent: "Europe", flagIcon: "🇲🇰")
        createCountry(fullName: "Norway", shortName: "NOR", continent: "Europe", flagIcon: "🇳🇴")
        createCountry(fullName: "Poland", shortName: "POL", continent: "Europe", flagIcon: "🇵🇱")
        createCountry(fullName: "Portugal", shortName: "PRT", continent: "Europe", flagIcon: "🇵🇹")
        createCountry(fullName: "Romania", shortName: "ROU", continent: "Europe", flagIcon: "🇷🇴")
        createCountry(fullName: "Russia", shortName: "RUS", continent: "Europe", flagIcon: "🇷🇺")
        createCountry(fullName: "San Marino", shortName: "SMR", continent: "Europe", flagIcon: "🇸🇲")
        createCountry(fullName: "Serbia", shortName: "SRB", continent: "Europe", flagIcon: "🇷🇸")
        createCountry(fullName: "Slovakia", shortName: "SVK", continent: "Europe", flagIcon: "🇸🇰")
        createCountry(fullName: "Slovenia", shortName: "SVN", continent: "Europe", flagIcon: "🇸🇮")
        createCountry(fullName: "Spain", shortName: "ESP", continent: "Europe", flagIcon: "🇪🇸")
        createCountry(fullName: "Sweden", shortName: "SWE", continent: "Europe", flagIcon: "🇸🇪")
        createCountry(fullName: "Switzerland", shortName: "CHE", continent: "Europe", flagIcon: "🇨🇭")
        createCountry(fullName: "Turkey", shortName: "TUR", continent: "Europe", flagIcon: "🇹🇷")
        createCountry(fullName: "Ukraine", shortName: "UKR", continent: "Europe", flagIcon: "🇺🇦")
        createCountry(fullName: "United Kingdom", shortName: "GBR", continent: "Europe", flagIcon: "🇬🇧")
        createCountry(fullName: "Vatican City", shortName: "VAT", continent: "Europe", flagIcon: "🇻🇦")
        // Asia
        createCountry(fullName: "Afghanistan", shortName: "AFG", continent: "Asia", flagIcon: "🇦🇫")
        createCountry(fullName: "Armenia", shortName: "ARM", continent: "Asia", flagIcon: "🇦🇲")
        createCountry(fullName: "Azerbaijan", shortName: "AZE", continent: "Asia", flagIcon: "🇦🇿")
        createCountry(fullName: "Bahrain", shortName: "BHR", continent: "Asia", flagIcon: "🇧🇭")
        createCountry(fullName: "Bangladesh", shortName: "BGD", continent: "Asia", flagIcon: "🇧🇩")
        createCountry(fullName: "Bhutan", shortName: "BTN", continent: "Asia", flagIcon: "🇧🇹")
        createCountry(fullName: "Brunei", shortName: "BRN", continent: "Asia", flagIcon: "🇧🇳")
        createCountry(fullName: "Cambodia", shortName: "KHM", continent: "Asia", flagIcon: "🇰🇭")
        createCountry(fullName: "China", shortName: "CHN", continent: "Asia", flagIcon: "🇨🇳")
        createCountry(fullName: "Georgia", shortName: "GEO", continent: "Asia", flagIcon: "🇬🇪")
        createCountry(fullName: "India", shortName: "IND", continent: "Asia", flagIcon: "🇮🇳")
        createCountry(fullName: "Indonesia", shortName: "IDN", continent: "Asia", flagIcon: "🇮🇩")
        createCountry(fullName: "Iran", shortName: "IRN", continent: "Asia", flagIcon: "🇮🇷")
        createCountry(fullName: "Iraq", shortName: "IRQ", continent: "Asia", flagIcon: "🇮🇶")
        createCountry(fullName: "Israel", shortName: "ISR", continent: "Asia", flagIcon: "🇮🇱")
        createCountry(fullName: "Japan", shortName: "JPN", continent: "Asia", flagIcon: "🇯🇵")
        createCountry(fullName: "Jordan", shortName: "JOR", continent: "Asia", flagIcon: "🇯🇴")
        createCountry(fullName: "Kazakhstan", shortName: "KAZ", continent: "Asia", flagIcon: "🇰🇿")
        createCountry(fullName: "Kuwait", shortName: "KWT", continent: "Asia", flagIcon: "🇰🇼")
        createCountry(fullName: "Kyrgyzstan", shortName: "KGZ", continent: "Asia", flagIcon: "🇰🇬")
        createCountry(fullName: "Laos", shortName: "LAO", continent: "Asia", flagIcon: "🇱🇦")
        createCountry(fullName: "Lebanon", shortName: "LBN", continent: "Asia", flagIcon: "🇱🇧")
        createCountry(fullName: "Malaysia", shortName: "MYS", continent: "Asia", flagIcon: "🇲🇾")
        createCountry(fullName: "Maldives", shortName: "MDV", continent: "Asia", flagIcon: "🇲🇻")
        createCountry(fullName: "Mongolia", shortName: "MNG", continent: "Asia", flagIcon: "🇲🇳")
        createCountry(fullName: "Myanmar", shortName: "MMR", continent: "Asia", flagIcon: "🇲🇲")
        createCountry(fullName: "Nepal", shortName: "NPL", continent: "Asia", flagIcon: "🇳🇵")
        createCountry(fullName: "North Korea", shortName: "PRK", continent: "Asia", flagIcon: "🇰🇵")
        createCountry(fullName: "Oman", shortName: "OMN", continent: "Asia", flagIcon: "🇴🇲")
        createCountry(fullName: "Pakistan", shortName: "PAK", continent: "Asia", flagIcon: "🇵🇰")
        createCountry(fullName: "Palestine", shortName: "PSE", continent: "Asia", flagIcon: "🇵🇸")
        createCountry(fullName: "Philippines", shortName: "PHL", continent: "Asia", flagIcon: "🇵🇭")
        createCountry(fullName: "Qatar", shortName: "QAT", continent: "Asia", flagIcon: "🇶🇦")
        createCountry(fullName: "Saudi Arabia", shortName: "SAU", continent: "Asia", flagIcon: "🇸🇦")
        createCountry(fullName: "Singapore", shortName: "SGP", continent: "Asia", flagIcon: "🇸🇬")
        createCountry(fullName: "South Korea", shortName: "KOR", continent: "Asia", flagIcon: "🇰🇷")
        createCountry(fullName: "Sri Lanka", shortName: "LKA", continent: "Asia", flagIcon: "🇱🇰")
        createCountry(fullName: "Syria", shortName: "SYR", continent: "Asia", flagIcon: "🇸🇾")
        createCountry(fullName: "Taiwan", shortName: "TWN", continent: "Asia", flagIcon: "🇹🇼")
        createCountry(fullName: "Tajikistan", shortName: "TJK", continent: "Asia", flagIcon: "🇹🇯")
        createCountry(fullName: "Thailand", shortName: "THA", continent: "Asia", flagIcon: "🇹🇭")
        createCountry(fullName: "Timor-Leste", shortName: "TLS", continent: "Asia", flagIcon: "🇹🇱")
        createCountry(fullName: "Turkmenistan", shortName: "TKM", continent: "Asia", flagIcon: "🇹🇲")
        createCountry(fullName: "United Arab Emirates", shortName: "ARE", continent: "Asia", flagIcon: "🇦🇪")
        createCountry(fullName: "Uzbekistan", shortName: "UZB", continent: "Asia", flagIcon: "🇺🇿")
        createCountry(fullName: "Vietnam", shortName: "VNM", continent: "Asia", flagIcon: "🇻🇳")
        createCountry(fullName: "Yemen", shortName: "YEM", continent: "Asia", flagIcon: "🇾🇪")
        // North America
        createCountry(fullName: "Antigua and Barbuda", shortName: "ATG", continent: "North America", flagIcon: "🇦🇬")
        createCountry(fullName: "Bahamas", shortName: "BHS", continent: "North America", flagIcon: "🇧🇸")
        createCountry(fullName: "Barbados", shortName: "BRB", continent: "North America", flagIcon: "🇧🇧")
        createCountry(fullName: "Belize", shortName: "BLZ", continent: "North America", flagIcon: "🇧🇿")
        createCountry(fullName: "Canada", shortName: "CAN", continent: "North America", flagIcon: "🇨🇦")
        createCountry(fullName: "Costa Rica", shortName: "CRI", continent: "North America", flagIcon: "🇨🇷")
        createCountry(fullName: "Cuba", shortName: "CUB", continent: "North America", flagIcon: "🇨🇺")
        createCountry(fullName: "Dominica", shortName: "DMA", continent: "North America", flagIcon: "🇩🇲")
        createCountry(fullName: "Dominican Republic", shortName: "DOM", continent: "North America", flagIcon: "🇩🇴")
        createCountry(fullName: "El Salvador", shortName: "SLV", continent: "North America", flagIcon: "🇸🇻")
        createCountry(fullName: "Grenada", shortName: "GRD", continent: "North America", flagIcon: "🇬🇩")
        createCountry(fullName: "Guatemala", shortName: "GTM", continent: "North America", flagIcon: "🇬🇹")
        createCountry(fullName: "Haiti", shortName: "HTI", continent: "North America", flagIcon: "🇭🇹")
        createCountry(fullName: "Honduras", shortName: "HND", continent: "North America", flagIcon: "🇭🇳")
        createCountry(fullName: "Jamaica", shortName: "JAM", continent: "North America", flagIcon: "🇯🇲")
        createCountry(fullName: "Mexico", shortName: "MEX", continent: "North America", flagIcon: "🇲🇽")
        createCountry(fullName: "Nicaragua", shortName: "NIC", continent: "North America", flagIcon: "🇳🇮")
        createCountry(fullName: "Panama", shortName: "PAN", continent: "North America", flagIcon: "🇵🇦")
        createCountry(fullName: "Saint Kitts and Nevis", shortName: "KNA", continent: "North America", flagIcon: "🇰🇳")
        createCountry(fullName: "Saint Lucia", shortName: "LCA", continent: "North America", flagIcon: "🇱🇨")
        createCountry(fullName: "Saint Vincent", shortName: "VCT", continent: "North America", flagIcon: "🇻🇨")
        createCountry(fullName: "Trinidad and Tobago", shortName: "TTO", continent: "North America", flagIcon: "🇹🇹")
        createCountry(fullName: "USA", shortName: "USA", continent: "North America", flagIcon: "🇺🇸")
        // Oceania
        createCountry(fullName: "Australia", shortName: "AUS", continent: "Oceania", flagIcon: "🇦🇺")
        createCountry(fullName: "Fiji", shortName: "FJI", continent: "Oceania", flagIcon: "🇫🇯")
        createCountry(fullName: "Kiribati", shortName: "KIR", continent: "Oceania", flagIcon: "🇰🇮")
        createCountry(fullName: "Marshall Islands", shortName: "MHL", continent: "Oceania", flagIcon: "🇲🇭")
        createCountry(fullName: "Micronesia", shortName: "FSM", continent: "Oceania", flagIcon: "🇫🇲")
        createCountry(fullName: "Nauru", shortName: "NRU", continent: "Oceania", flagIcon: "🇳🇷")
        createCountry(fullName: "New Zealand", shortName: "NZL", continent: "Oceania", flagIcon: "🇳🇿")
        createCountry(fullName: "Palau", shortName: "PLW", continent: "Oceania", flagIcon: "🇵🇼")
        createCountry(fullName: "Papua New Guinea", shortName: "PNG", continent: "Oceania", flagIcon: "🇵🇬")
        createCountry(fullName: "Samoa", shortName: "WSM", continent: "Oceania", flagIcon: "🇼🇸")
        createCountry(fullName: "Solomon Islands", shortName: "SLB", continent: "Oceania", flagIcon: "🇸🇧")
        createCountry(fullName: "Tonga", shortName: "TON", continent: "Oceania", flagIcon: "🇹🇴")
        createCountry(fullName: "Tuvalu", shortName: "TUV", continent: "Oceania", flagIcon: "🇹🇻")
        createCountry(fullName: "Vanuatu", shortName: "VUT", continent: "Oceania", flagIcon: "🇻🇺")
        // Africa
        createCountry(fullName: "Algeria", shortName: "DZA", continent: "Africa", flagIcon: "🇩🇿")
        createCountry(fullName: "Angola", shortName: "AGO", continent: "Africa", flagIcon: "🇦🇴")
        createCountry(fullName: "Benin", shortName: "BEN", continent: "Africa", flagIcon: "🇧🇯")
        createCountry(fullName: "Botswana", shortName: "BWA", continent: "Africa", flagIcon: "🇧🇼")
        createCountry(fullName: "Burkina Faso", shortName: "BFA", continent: "Africa", flagIcon: "🇧🇫")
        createCountry(fullName: "Burundi", shortName: "BDI", continent: "Africa", flagIcon: "🇧🇮")
        createCountry(fullName: "Cameroon", shortName: "CMR", continent: "Africa", flagIcon: "🇨🇲")
        createCountry(fullName: "Cape Verde", shortName: "CPV", continent: "Africa", flagIcon: "🇨🇻")
        createCountry(fullName: "Central African Republic", shortName: "CAF", continent: "Africa", flagIcon: "🇨🇫")
        createCountry(fullName: "Chad", shortName: "TCD", continent: "Africa", flagIcon: "🇹🇩")
        createCountry(fullName: "Comoros", shortName: "COM", continent: "Africa", flagIcon: "🇰🇲")
        createCountry(fullName: "Côte d'Ivoire", shortName: "CIV", continent: "Africa", flagIcon: "🇨🇮")
        createCountry(fullName: "Democratic Republic of the Congo", shortName: "COD", continent: "Africa", flagIcon: "🇨🇩")
        createCountry(fullName: "Djibouti", shortName: "DJI", continent: "Africa", flagIcon: "🇩🇯")
        createCountry(fullName: "Egypt", shortName: "EGY", continent: "Africa", flagIcon: "🇪🇬")
        createCountry(fullName: "Equatorial Guinea", shortName: "GNQ", continent: "Africa", flagIcon: "🇬🇶")
        createCountry(fullName: "Eritrea", shortName: "ERI", continent: "Africa", flagIcon: "🇪🇷")
        createCountry(fullName: "Eswatini", shortName: "SWZ", continent: "Africa", flagIcon: "🇸🇿")
        createCountry(fullName: "Ethiopia", shortName: "ETH", continent: "Africa", flagIcon: "🇪🇹")
        createCountry(fullName: "Gabon", shortName: "GAB", continent: "Africa", flagIcon: "🇬🇦")
        createCountry(fullName: "Gambia", shortName: "GMB", continent: "Africa", flagIcon: "🇬🇲")
        createCountry(fullName: "Ghana", shortName: "GHA", continent: "Africa", flagIcon: "🇬🇭")
        createCountry(fullName: "Guinea", shortName: "GIN", continent: "Africa", flagIcon: "🇬🇳")
        createCountry(fullName: "Guinea-Bissau", shortName: "GNB", continent: "Africa", flagIcon: "🇬🇼")
        createCountry(fullName: "Kenya", shortName: "KEN", continent: "Africa", flagIcon: "🇰🇪")
        createCountry(fullName: "Lesotho", shortName: "LSO", continent: "Africa", flagIcon: "🇱🇸")
        createCountry(fullName: "Liberia", shortName: "LBR", continent: "Africa", flagIcon: "🇱🇷")
        createCountry(fullName: "Libya", shortName: "LBY", continent: "Africa", flagIcon: "🇱🇾")
        createCountry(fullName: "Madagascar", shortName: "MDG", continent: "Africa", flagIcon: "🇲🇬")
        createCountry(fullName: "Malawi", shortName: "MWI", continent: "Africa", flagIcon: "🇲🇼")
        createCountry(fullName: "Mali", shortName: "MLI", continent: "Africa", flagIcon: "🇲🇱")
        createCountry(fullName: "Mauritania", shortName: "MRT", continent: "Africa", flagIcon: "🇲🇷")
        createCountry(fullName: "Mauritius", shortName: "MUS", continent: "Africa", flagIcon: "🇲🇺")
        createCountry(fullName: "Morocco", shortName: "MAR", continent: "Africa", flagIcon: "🇲🇦")
        createCountry(fullName: "Mozambique", shortName: "MOZ", continent: "Africa", flagIcon: "🇲🇿")
        createCountry(fullName: "Namibia", shortName: "NAM", continent: "Africa", flagIcon: "🇳🇦")
        createCountry(fullName: "Niger", shortName: "NER", continent: "Africa", flagIcon: "🇳🇪")
        createCountry(fullName: "Nigeria", shortName: "NGA", continent: "Africa", flagIcon: "🇳🇬")
        createCountry(fullName: "Republic of the Congo", shortName: "COG", continent: "Africa", flagIcon: "🇨🇬")
        createCountry(fullName: "Rwanda", shortName: "RWA", continent: "Africa", flagIcon: "🇷🇼")
        createCountry(fullName: "São Tomé and Príncipe", shortName: "STP", continent: "Africa", flagIcon: "🇸🇹")
        createCountry(fullName: "Senegal", shortName: "SEN", continent: "Africa", flagIcon: "🇸🇳")
        createCountry(fullName: "Seychelles", shortName: "SYC", continent: "Africa", flagIcon: "🇸🇨")
        createCountry(fullName: "Sierra Leone", shortName: "SLE", continent: "Africa", flagIcon: "🇸🇱")
        createCountry(fullName: "Somalia", shortName: "SOM", continent: "Africa", flagIcon: "🇸🇴")
        createCountry(fullName: "South Africa", shortName: "ZAF", continent: "Africa", flagIcon: "🇿🇦")
        createCountry(fullName: "South Sudan", shortName: "SSD", continent: "Africa", flagIcon: "🇸🇸")
        createCountry(fullName: "Sudan", shortName: "SDN", continent: "Africa", flagIcon: "🇸🇩")
        createCountry(fullName: "Tanzania", shortName: "TZA", continent: "Africa", flagIcon: "🇹🇿")
        createCountry(fullName: "Togo", shortName: "TGO", continent: "Africa", flagIcon: "🇹🇬")
        createCountry(fullName: "Tunisia", shortName: "TUN", continent: "Africa", flagIcon: "🇹🇳")
        createCountry(fullName: "Uganda", shortName: "UGA", continent: "Africa", flagIcon: "🇺🇬")
        createCountry(fullName: "Zambia", shortName: "ZMB", continent: "Africa", flagIcon: "🇿🇲")
        createCountry(fullName: "Zimbabwe", shortName: "ZWE", continent: "Africa", flagIcon: "🇿🇼")
        // South America
        createCountry(fullName: "Argentina", shortName: "ARG", continent: "South America", flagIcon: "🇦🇷")
        createCountry(fullName: "Bolivia", shortName: "BOL", continent: "South America", flagIcon: "🇧🇴")
        createCountry(fullName: "Brazil", shortName: "BRA", continent: "South America", flagIcon: "🇧🇷")
        createCountry(fullName: "Chile", shortName: "CHL", continent: "South America", flagIcon: "🇨🇱")
        createCountry(fullName: "Colombia", shortName: "COL", continent: "South America", flagIcon: "🇨🇴")
        createCountry(fullName: "Ecuador", shortName: "ECU", continent: "South America", flagIcon: "🇪🇨")
        createCountry(fullName: "Guyana", shortName: "GUY", continent: "South America", flagIcon: "🇬🇾")
        createCountry(fullName: "Paraguay", shortName: "PRY", continent: "South America", flagIcon: "🇵🇾")
        createCountry(fullName: "Peru", shortName: "PER", continent: "South America", flagIcon: "🇵🇪")
        createCountry(fullName: "Suriname", shortName: "SUR", continent: "South America", flagIcon: "🇸🇷")
        createCountry(fullName: "Uruguay", shortName: "URY", continent: "South America", flagIcon: "🇺🇾")
        createCountry(fullName: "Venezuela", shortName: "VEN", continent: "South America", flagIcon: "🇻🇪")
    }
}
