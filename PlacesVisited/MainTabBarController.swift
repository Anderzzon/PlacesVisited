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
    var countryOverlays: [CountryGeo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
           let managedContext = appDelegate!.persistentContainer.viewContext
           
           countries = ListOfCountries(context: managedContext)
        
        //Run this to delete all:
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
        
        //Europe:
        countries.createCountry(fullName: "Albania", shortName: "ALB", continent: "Europe", flagIcon: "🇦🇱")
        countries.createCountry(fullName: "Andorra", shortName: "AND", continent: "Europe", flagIcon: "🇦🇩")
        countries.createCountry(fullName: "Armenia", shortName: "ARM", continent: "Europe", flagIcon: "🇦🇲")
        countries.createCountry(fullName: "Austria", shortName: "AUT", continent: "Europe", flagIcon: "🇦🇹")
        countries.createCountry(fullName: "Azerbaijan", shortName: "AZE", continent: "Europe", flagIcon: "🇦🇿")
        countries.createCountry(fullName: "Belarus", shortName: "BLR", continent: "Europe", flagIcon: "🇧🇾")
        countries.createCountry(fullName: "Belgium", shortName: "BEL", continent: "Europe", flagIcon: "🇧🇪")
        countries.createCountry(fullName: "Bosnia and Herzegovina", shortName: "BIH", continent: "Europe", flagIcon: "🇧🇦")
        countries.createCountry(fullName: "Bulgaria", shortName: "BGR", continent: "Europe", flagIcon: "🇧🇬")
        countries.createCountry(fullName: "Croatia", shortName: "HRV", continent: "Europe", flagIcon: "🇭🇷")
        countries.createCountry(fullName: "Cyprus", shortName: "CYP", continent: "Europe", flagIcon: "🇨🇾")
        countries.createCountry(fullName: "Czechia", shortName: "CZE", continent: "Europe", flagIcon: "🇨🇿")
        countries.createCountry(fullName: "Denmark", shortName: "DNK", continent: "Europe", flagIcon: "🇩🇰")
        countries.createCountry(fullName: "Estonia", shortName: "EST", continent: "Europe", flagIcon: "🇪🇪")
        countries.createCountry(fullName: "Finland", shortName: "FIN", continent: "Europe", flagIcon: "🇫🇮")
        countries.createCountry(fullName: "France", shortName: "FRA", continent: "Europe", flagIcon: "🇫🇷")
        countries.createCountry(fullName: "Georgia", shortName: "GEO", continent: "Europe", flagIcon: "🇬🇪")
        countries.createCountry(fullName: "Germany", shortName: "DEU", continent: "Europe", flagIcon: "🇩🇪")
        countries.createCountry(fullName: "Greece", shortName: "GRC", continent: "Europe", flagIcon: "🇬🇷")
        countries.createCountry(fullName: "Hungary", shortName: "HUN", continent: "Europe", flagIcon: "🇭🇺")
        countries.createCountry(fullName: "Iceland", shortName: "ISL", continent: "Europe", flagIcon: "🇮🇸")
        countries.createCountry(fullName: "Ireland", shortName: "IRL", continent: "Europe", flagIcon: "🇮🇪")
        countries.createCountry(fullName: "Italy", shortName: "ITA", continent: "Europe", flagIcon: "🇮🇹")
        countries.createCountry(fullName: "Kazakhstan", shortName: "KAZ", continent: "Europe", flagIcon: "🇰🇿")
        //countries.createCountry(fullName: "Kosovo", shortName: "RKS", continent: "Europe", flagIcon: "🇽🇰")
        countries.createCountry(fullName: "Latvia", shortName: "LVA", continent: "Europe", flagIcon: "🇱🇻")
        countries.createCountry(fullName: "Liechtenstein", shortName: "LIE", continent: "Europe", flagIcon: "🇱🇮")
        countries.createCountry(fullName: "Lithuania", shortName: "LTU", continent: "Europe", flagIcon: "🇱🇹")
        countries.createCountry(fullName: "Luxembourg", shortName: "LUX", continent: "Europe", flagIcon: "🇱🇺")
        countries.createCountry(fullName: "Malta", shortName: "MLT", continent: "Europe", flagIcon: "🇲🇹")
        countries.createCountry(fullName: "Moldova", shortName: "MDA", continent: "Europe", flagIcon: "🇲🇩")
        countries.createCountry(fullName: "Monaco", shortName: "MCO", continent: "Europe", flagIcon: "🇲🇨")
        countries.createCountry(fullName: "Montenegro", shortName: "MNE", continent: "Europe", flagIcon: "🇲🇪")
        countries.createCountry(fullName: "Netherlands", shortName: "NLD", continent: "Europe", flagIcon: "🇳🇱")
        countries.createCountry(fullName: "North Macedonia", shortName: "MKD", continent: "Europe", flagIcon: "🇲🇰")
        
        countries.createCountry(fullName: "Russia", shortName: "RUS", continent: "Europe", flagIcon: "🇷🇺")
        countries.createCountry(fullName: "Sweden", shortName:"SWE", continent:"Europe", flagIcon:"🇸🇪")
        countries.createCountry(fullName: "United Kingdom", shortName: "GBR", continent: "Europe", flagIcon: "🇬🇧")
        countries.createCountry(fullName: "Vatican City", shortName: "VAT", continent: "Europe", flagIcon: "🇻🇦")
        
        countries.createCountry(fullName: "China", shortName:"CHN", continent:"Asia", flagIcon:"🇨🇳")
        countries.createCountry(fullName: "USA", shortName: "USA", continent: "North America", flagIcon: "🇺🇸")
        
        countries.createCountry(fullName: "Thailand", shortName: "THA", continent: "Asia", flagIcon: "🇹🇭")
        
        
        countries.createCountry(fullName: "Australia", shortName: "AUS", continent: "Oceania", flagIcon: "🇦🇺")
        
        countries.createCountry(fullName: "South Africa", shortName: "ZAF", continent: "Africa", flagIcon: "🇿🇦")
        countries.createCountry(fullName: "Egypt", shortName: "EGY", continent: "Africa", flagIcon: "🇪🇬")
        countries.createCountry(fullName: "Singapore", shortName: "SGP", continent: "Asia", flagIcon: "🇸🇬")
        countries.createCountry(fullName: "Brazil", shortName: "BRA", continent: "South America", flagIcon: "🇧🇷")
        countries.createCountry(fullName: "Peru", shortName: "PER", continent: "South America", flagIcon: "🇵🇪")
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
