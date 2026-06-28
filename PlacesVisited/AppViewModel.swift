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

struct YearDataPoint: Identifiable {
    var id: String { "\(isProjection ? "p" : "a")-\(year)" }
    let year: Int
    let count: Int
    let isProjection: Bool
}

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

    private var countriesInEurope: [Country] = []
    private var countriesInAsia: [Country] = []
    private var countriesInNorthAmerica: [Country] = []
    private var countriesInAfrica: [Country] = []
    private var countriesInSouthAmerica: [Country] = []
    private var countriesInOceania: [Country] = []
    @Published var travelProgressChartData: [YearDataPoint] = []
    
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
            let asia = try managedContext.fetch(fetchAsia)
            let europe = try managedContext.fetch(fetchEurope)
            let africa = try managedContext.fetch(fetchAfrica)
            let northAmerica = try managedContext.fetch(fetchNorthAmerica)
            let southAmerica = try managedContext.fetch(fetchSouthAmerica)
            let oceania = try managedContext.fetch(fetchOceania)

            objectWillChange.send()
            countriesInAsia = asia
            countriesInEurope = europe
            countriesInAfrica = africa
            countriesInNorthAmerica = northAmerica
            countriesInSouthAmerica = southAmerica
            countriesInOceania = oceania
            travelProgressChartData = buildTravelProgressChartData()

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
    
    
    func saveCountryStatus(country: Country, visited: Bool, wantToGo: Bool, firstVisited: Date?) {
        let fetchRequest: NSFetchRequest<Country> = NSFetchRequest.init(entityName: "Country")
        fetchRequest.predicate = NSPredicate(format: "fullName = %@", country.fullName)
        do {
            let results = try managedContext.fetch(fetchRequest)
            guard let objectUpdate = results.first as? NSManagedObject else { return }
            objectUpdate.setValue(visited, forKey: "visited")
            objectUpdate.setValue(wantToGo, forKey: "wantToGo")
            objectUpdate.setValue(visited ? firstVisited : nil, forKey: "firstVisited")
            objectUpdate.setValue(true, forKey: "updateMap")
            try managedContext.save()
            loadItems()
        } catch {
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
    
    private func buildTravelProgressChartData() -> [YearDataPoint] {
        let allCountries = countriesInEurope + countriesInAsia + countriesInNorthAmerica +
                           countriesInAfrica + countriesInSouthAmerica + countriesInOceania
        let calendar = Calendar.current
        let visitedYears = allCountries
            .filter { $0.visited }
            .compactMap { $0.firstVisited }
            .map { calendar.component(.year, from: $0) }

        print("[Chart] visited countries with dates: \(visitedYears.count)")

        guard !visitedYears.isEmpty else {
            print("[Chart] no dated visits — returning empty")
            return []
        }

        let firstYear = visitedYears.min()!
        let currentYear = calendar.component(.year, from: Date())
        print("[Chart] year range: \(firstYear)–\(currentYear)")

        var countByYear: [Int: Int] = [:]
        for year in visitedYears {
            countByYear[year, default: 0] += 1
        }
        print("[Chart] counts per year: \(countByYear.sorted { $0.key < $1.key })")

        var result: [YearDataPoint] = []
        var cumulative = 0
        for year in firstYear...currentYear {
            cumulative += countByYear[year, default: 0]
            result.append(YearDataPoint(year: year, count: cumulative, isProjection: false))
        }
        print("[Chart] actual data points: \(result.map { "\($0.year):\($0.count)" })")

        let bucketList = numberOfCountriesWantToGoTo
        guard bucketList > 0 else {
            print("[Chart] no bucket list items — skipping projection")
            return result
        }

        let yearsActive = currentYear - firstYear + 1
        let avgPerYear = Double(numberOfCountriesVisited) / Double(yearsActive)
        print("[Chart] avgPerYear: \(avgPerYear), target: \(numberOfCountriesVisited + bucketList)")
        guard avgPerYear > 0 else { return result }

        let target = numberOfCountriesVisited + bucketList
        let yearsToComplete = Int((Double(bucketList) / avgPerYear).rounded(.up))
        let endYear = min(currentYear + yearsToComplete, currentYear + 100)

        result.append(YearDataPoint(year: currentYear, count: cumulative, isProjection: true))
        result.append(YearDataPoint(year: endYear, count: target, isProjection: true))
        print("[Chart] projection: \(currentYear) → \(endYear), total points: \(result.count)")

        return result
    }

    func bucketListProgress() -> Double {
        let total = numberOfCountriesVisited + numberOfCountriesWantToGoTo
        guard total > 0 else { return 0 }
        var percent = Double(numberOfCountriesVisited) / Double(total)
        percent = percent * 100
        percent = Double(round(10 * percent) / 10)
        return percent
    }

    // Reads seed.json from the app bundle and creates one Country record per entry
    func seedDatabase() {
        guard let url = Bundle.main.url(forResource: "seed", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let entries = try? JSONSerialization.jsonObject(with: data) as? [[String: String]]
        else { return }

        for entry in entries {
            guard let fullName  = entry["fullName"],
                  let shortName = entry["shortName"],
                  let continent = entry["continent"],
                  let flagIcon  = entry["flagIcon"]
            else { continue }
            createCountry(fullName: fullName, shortName: shortName, continent: continent, flagIcon: flagIcon)
        }
    }
}
