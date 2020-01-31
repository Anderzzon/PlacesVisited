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
           
           //countries.loadItems()
           
        countries.createCountry(fullName:"Sweden", shortName:"SWE", continent:"Europe", flagIcon:"🇸🇪")
        countries.createCountry(fullName: "Denmark", shortName: "DEN", continent: "Europe", flagIcon: "🇩🇰")
        countries.createCountry(fullName:"China", shortName:"CHI", continent:"Asia", flagIcon:"🇨🇳")
        
        
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
        }
        
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
