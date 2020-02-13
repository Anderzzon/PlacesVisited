//
//  MainTabBarController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-30.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var countries : ListOfCountries!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
           let managedContext = appDelegate!.persistentContainer.viewContext
           
           countries = ListOfCountries(context: managedContext)
        
        //countries.deleteData()
        
        //Run this to create all countries:
        //createDatabase()
        
        //load countries from database if there is any:
        countries.loadItems()
        
        guard let viewControllers = viewControllers else {return}
        
        for viewController in viewControllers {
            
            if let tableViewNavigationViewController = viewController as? TableViewNavigationViewController {
                
                if let countriesTableViewController = tableViewNavigationViewController.viewControllers.first as? CountriesTableViewController {
                    countriesTableViewController.countries = countries
                }
            }
                
                if let statsViewController = viewController as? StatsViewController {
                    statsViewController.countries = countries
                }
            
            if let worldMapViewController = viewController as? WorldMapViewController {
                worldMapViewController.countries = countries
            }
        }
        
    }
    
    func createDatabase() {
        
        countries.createCountry(fullName:"Sweden", shortName:"SWE", continent:"Europe", flagIcon:"🇸🇪")
        countries.createCountry(fullName: "Denmark", shortName: "DEN", continent: "Europe", flagIcon: "🇩🇰")
        countries.createCountry(fullName:"China", shortName:"CHI", continent:"Asia", flagIcon:"🇨🇳")
        countries.createCountry(fullName: "USA", shortName: "USA", continent: "North America", flagIcon: "🇺🇸")
        countries.createCountry(fullName: "France", shortName: "FRA", continent: "Europe", flagIcon: "🇫🇷")
        countries.createCountry(fullName: "Thailand", shortName: "THI", continent: "Asia", flagIcon: "🇹🇭")
        countries.createCountry(fullName: "Finland", shortName: "FIN", continent: "Europe", flagIcon: "🇫🇮")
        countries.createCountry(fullName: "Germany", shortName: "GER", continent: "Europe", flagIcon: "🇩🇪")
        countries.createCountry(fullName: "Australia", shortName: "AUS", continent: "Oceania", flagIcon: "🇦🇺")
        countries.createCountry(fullName: "Greece", shortName: "GRE", continent: "Europe", flagIcon: "🇬🇷")
        countries.createCountry(fullName: "Belgium", shortName: "BEL", continent: "Europe", flagIcon: "🇧🇪")
        countries.createCountry(fullName: "South Africa", shortName: "SOA", continent: "Africa", flagIcon: "🇿🇦")
        countries.createCountry(fullName: "Egypt", shortName: "EGY", continent: "Africa", flagIcon: "🇪🇬")
        countries.createCountry(fullName: "Singapore", shortName: "SIN", continent: "Asia", flagIcon: "🇸🇬")
        countries.createCountry(fullName: "Brazil", shortName: "BRZ", continent: "South America", flagIcon: "🇧🇷")
        countries.createCountry(fullName: "Peru", shortName: "PRU", continent: "South America", flagIcon: "🇵🇪")
        countries.createCountry(fullName: "Argentina", shortName: "ARG", continent: "South America", flagIcon: "🇦🇷")
        countries.createCountry(fullName: "Mexico", shortName: "MEX", continent: "North America", flagIcon: "🇲🇽")
        countries.createCountry(fullName: "Canada", shortName: "CAN", continent: "North America", flagIcon: "🇨🇦")
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
