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
        countries.createCountry(fullName: "Austria", shortName: "AUT", continent: "Europe", flagIcon: "🇦🇹")
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
        countries.createCountry(fullName: "Germany", shortName: "DEU", continent: "Europe", flagIcon: "🇩🇪")
        countries.createCountry(fullName: "Greece", shortName: "GRC", continent: "Europe", flagIcon: "🇬🇷")
        countries.createCountry(fullName: "Hungary", shortName: "HUN", continent: "Europe", flagIcon: "🇭🇺")
        countries.createCountry(fullName: "Iceland", shortName: "ISL", continent: "Europe", flagIcon: "🇮🇸")
        countries.createCountry(fullName: "Ireland", shortName: "IRL", continent: "Europe", flagIcon: "🇮🇪")
        countries.createCountry(fullName: "Italy", shortName: "ITA", continent: "Europe", flagIcon: "🇮🇹")
        countries.createCountry(fullName: "Kosovo", shortName: "RKS", continent: "Europe", flagIcon: "🇽🇰")
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
        countries.createCountry(fullName: "Norway", shortName: "NOR", continent: "Europe", flagIcon: "🇳🇴")
        countries.createCountry(fullName: "Poland", shortName: "POL", continent: "Europe", flagIcon: "🇵🇱")
        countries.createCountry(fullName: "Portugal", shortName: "PRT", continent: "Europe", flagIcon: "🇵🇹")
        countries.createCountry(fullName: "Romania", shortName: "ROU", continent: "Europe", flagIcon: "🇷🇴")
        countries.createCountry(fullName: "Russia", shortName: "RUS", continent: "Europe", flagIcon: "🇷🇺")
        countries.createCountry(fullName: "San Marino", shortName: "SMR", continent: "Europe", flagIcon: "🇸🇲")
        countries.createCountry(fullName: "Serbia", shortName: "SRB", continent: "Europe", flagIcon: "🇷🇸")
        countries.createCountry(fullName: "Slovakia", shortName: "SVK", continent: "Europe", flagIcon: "🇸🇰")
        countries.createCountry(fullName: "Slovenia", shortName: "SVN", continent: "Europe", flagIcon: "🇸🇮")
        countries.createCountry(fullName: "Spain", shortName: "ESP", continent: "Europe", flagIcon: "🇪🇸")
        countries.createCountry(fullName: "Sweden", shortName:"SWE", continent:"Europe", flagIcon:"🇸🇪")
        countries.createCountry(fullName: "Switzerland", shortName: "CHE", continent: "Europe", flagIcon: "🇨🇭")
        countries.createCountry(fullName: "Turkey", shortName: "TUR", continent: "Europe", flagIcon: "🇹🇷")
        countries.createCountry(fullName: "Ukraine", shortName: "UKR", continent: "Europe", flagIcon: "🇺🇦")
        countries.createCountry(fullName: "United Kingdom", shortName: "GBR", continent: "Europe", flagIcon: "🇬🇧")
        countries.createCountry(fullName: "Vatican City", shortName: "VAT", continent: "Europe", flagIcon: "🇻🇦")
        
        //Asia:
        countries.createCountry(fullName: "Afghanistan", shortName: "AFG", continent: "Asia", flagIcon: "🇦🇫")
        countries.createCountry(fullName: "Armenia", shortName: "ARM", continent: "Asia", flagIcon: "🇦🇲")
        countries.createCountry(fullName: "Azerbaijan", shortName: "AZE", continent: "Asia", flagIcon: "🇦🇿")
        countries.createCountry(fullName: "Bahrain", shortName: "BHR", continent: "Asia", flagIcon: "🇧🇭")
        countries.createCountry(fullName: "Bangladesh", shortName: "BGD", continent: "Asia", flagIcon: "🇧🇩")
        countries.createCountry(fullName: "Bhutan", shortName: "BTN", continent: "Asia", flagIcon: "🇧🇹")
        countries.createCountry(fullName: "Brunei", shortName: "BRN", continent: "Asia", flagIcon: "🇧🇳")
        countries.createCountry(fullName: "Cambodia", shortName: "KHM", continent: "Asia", flagIcon: "🇰🇭")
        countries.createCountry(fullName: "China", shortName:"CHN", continent:"Asia", flagIcon:"🇨🇳")
        countries.createCountry(fullName: "Georgia", shortName: "GEO", continent: "Asia", flagIcon: "🇬🇪")
        countries.createCountry(fullName: "India", shortName: "IND", continent: "Asia", flagIcon: "🇮🇳")
        countries.createCountry(fullName: "Indonesia", shortName: "IDN", continent: "Asia", flagIcon: "🇮🇩")
        countries.createCountry(fullName: "Iran", shortName: "IRN", continent: "Asia", flagIcon: "🇮🇷")
        countries.createCountry(fullName: "Iraq", shortName: "IRQ", continent: "Asia", flagIcon: "🇮🇶")
        countries.createCountry(fullName: "Israel", shortName: "ISR", continent: "Asia", flagIcon: "🇮🇱")
        countries.createCountry(fullName: "Japan", shortName: "JPN", continent: "Asia", flagIcon: "🇯🇵")
        countries.createCountry(fullName: "Jordan", shortName: "JOR", continent: "Asia", flagIcon: "🇯🇴")
        countries.createCountry(fullName: "Kazakhstan", shortName: "KAZ", continent: "Asia", flagIcon: "🇰🇿")
        countries.createCountry(fullName: "Kuwait", shortName: "KWT", continent: "Asia", flagIcon: "🇰🇼")
        countries.createCountry(fullName: "Kyrgyzstan", shortName: "KGZ", continent: "Asia", flagIcon: "🇰🇬")
        countries.createCountry(fullName: "Laos", shortName: "LAO", continent: "Asia", flagIcon: "🇱🇦")
        countries.createCountry(fullName: "Lebanon", shortName: "LBN", continent: "Asia", flagIcon: "🇱🇧")
        countries.createCountry(fullName: "Malaysia", shortName: "MYS", continent: "Asia", flagIcon: "🇲🇾")
        countries.createCountry(fullName: "Maldives", shortName: "MDV", continent: "Asia", flagIcon: "🇲🇻")
        countries.createCountry(fullName: "Mongolia", shortName: "MNG", continent: "Asia", flagIcon: "🇲🇳")
        countries.createCountry(fullName: "Myanmar", shortName: "MMR", continent: "Asia", flagIcon: "🇲🇲")
        countries.createCountry(fullName: "Nepal", shortName: "NPL", continent: "Asia", flagIcon: "🇳🇵")
        countries.createCountry(fullName: "North Korea", shortName: "PRK", continent: "Asia", flagIcon: "🇰🇵")
        countries.createCountry(fullName: "Oman", shortName: "OMN", continent: "Asia", flagIcon: "🇴🇲")
        countries.createCountry(fullName: "Pakistan", shortName: "PAK", continent: "Asia", flagIcon: "🇵🇰")
        countries.createCountry(fullName: "Palestine", shortName: "PSE", continent: "Asia", flagIcon: "🇵🇸")
        countries.createCountry(fullName: "Philippines", shortName: "PHL", continent: "Asia", flagIcon: "🇵🇭")
        countries.createCountry(fullName: "Qatar", shortName: "QAT", continent: "Asia", flagIcon: "🇶🇦")
        countries.createCountry(fullName: "Saudi Arabia", shortName: "SAU", continent: "Asia", flagIcon: "🇸🇦")
        countries.createCountry(fullName: "Singapore", shortName: "SGP", continent: "Asia", flagIcon: "🇸🇬")
        countries.createCountry(fullName: "South Korea", shortName: "KOR", continent: "Asia", flagIcon: "🇰🇷")
        countries.createCountry(fullName: "Sri Lanka", shortName: "LKA", continent: "Asia", flagIcon: "🇱🇰")
        countries.createCountry(fullName: "Syria", shortName: "SYR", continent: "Asia", flagIcon: "🇸🇾")
        countries.createCountry(fullName: "Taiwan", shortName: "TWN", continent: "Asia", flagIcon: "🇹🇼")
        countries.createCountry(fullName: "Tajikistan", shortName: "TJK", continent: "Asia", flagIcon: "🇹🇯")
        countries.createCountry(fullName: "Thailand", shortName: "THA", continent: "Asia", flagIcon: "🇹🇭")
        countries.createCountry(fullName: "Timor-Leste", shortName: "TLS", continent: "Asia", flagIcon: "🇹🇱")
        countries.createCountry(fullName: "Turkmenistan", shortName: "TKM", continent: "Asia", flagIcon: "🇹🇲")
        countries.createCountry(fullName: "United Arab Emirates", shortName: "ARE", continent: "Asia", flagIcon: "🇦🇪")
        countries.createCountry(fullName: "Uzbekistan", shortName: "UZB", continent: "Asia", flagIcon: "🇺🇿")
        countries.createCountry(fullName: "Vietnam", shortName: "VNM", continent: "Asia", flagIcon: "🇻🇳")
        countries.createCountry(fullName: "Yemen", shortName: "YEM", continent: "Asia", flagIcon: "🇾🇪")
        
        //North America:
        countries.createCountry(fullName: "Antigua and Barbuda", shortName: "ATG", continent: "North America", flagIcon: "🇦🇬")
        countries.createCountry(fullName: "Bahamas", shortName: "BHS", continent: "North America", flagIcon: "🇧🇸")
        countries.createCountry(fullName: "Barbados", shortName: "BRB", continent: "North America", flagIcon: "🇧🇧")
        countries.createCountry(fullName: "Belize", shortName: "BLZ", continent: "North America", flagIcon: "🇧🇿")
        countries.createCountry(fullName: "Canada", shortName: "CAN", continent: "North America", flagIcon: "🇨🇦")
        countries.createCountry(fullName: "Costa Rica", shortName: "CRI", continent: "North America", flagIcon: "🇨🇷")
        countries.createCountry(fullName: "Cuba", shortName: "CUB", continent: "North America", flagIcon: "🇨🇺")
        countries.createCountry(fullName: "Dominica", shortName: "DMA", continent: "North America", flagIcon: "🇩🇲")
        countries.createCountry(fullName: "Dominican Republic", shortName: "DOM", continent: "North America", flagIcon: "🇩🇴")
        countries.createCountry(fullName: "El Salvador", shortName: "SLV", continent: "North America", flagIcon: "🇸🇻")
        countries.createCountry(fullName: "Grenada", shortName: "GRD", continent: "North America", flagIcon: "🇬🇩")
        countries.createCountry(fullName: "Guatemala", shortName: "GTM", continent: "North America", flagIcon: "🇬🇹")
        countries.createCountry(fullName: "Haiti", shortName: "HTI", continent: "North America", flagIcon: "🇭🇹")
        countries.createCountry(fullName: "Honduras", shortName: "HND", continent: "North America", flagIcon: "🇭🇳")
        countries.createCountry(fullName: "Jamaica", shortName: "JAM", continent: "North America", flagIcon: "🇯🇲")
        countries.createCountry(fullName: "Mexico", shortName: "MEX", continent: "North America", flagIcon: "🇲🇽")
        countries.createCountry(fullName: "Nicaragua", shortName: "NIC", continent: "North America", flagIcon: "🇳🇮")
        countries.createCountry(fullName: "Panama", shortName: "PAN", continent: "North America", flagIcon: "🇵🇦")
        countries.createCountry(fullName: "Saint Kitts and Nevis", shortName: "KNA", continent: "North America", flagIcon: "🇰🇳")
        countries.createCountry(fullName: "Saint Lucia", shortName: "LCA", continent: "North America", flagIcon: "🇱🇨")
        countries.createCountry(fullName: "Saint Vincent", shortName: "VCT", continent: "North America", flagIcon: "🇻🇨")
        countries.createCountry(fullName: "Trinidad and Tobago", shortName: "TTO", continent: "North America", flagIcon: "🇹🇹")
        countries.createCountry(fullName: "USA", shortName: "USA", continent: "North America", flagIcon: "🇺🇸")
        
        //Ocenaia:
        countries.createCountry(fullName: "Australia", shortName: "AUS", continent: "Oceania", flagIcon: "🇦🇺")
        countries.createCountry(fullName: "Fiji", shortName: "FJI", continent: "Oceania", flagIcon: "🇫🇯")
        countries.createCountry(fullName: "Kiribati", shortName: "KIR", continent: "Oceania", flagIcon: "🇰🇮")
        countries.createCountry(fullName: "Marshall Islands", shortName: "MHL", continent: "Ocenaia", flagIcon: "🇲🇭")
        countries.createCountry(fullName: "Micronesia", shortName: "FSM", continent: "Oceania", flagIcon: "🇫🇲")
        countries.createCountry(fullName: "Nauru", shortName: "NRU", continent: "Oceania", flagIcon: "🇳🇷")
        countries.createCountry(fullName: "New Zealand", shortName: "NZL", continent: "Ocenaia", flagIcon: "🇳🇿")
        countries.createCountry(fullName: "Palau", shortName: "PLW", continent: "Ocenaia", flagIcon: "🇵🇼")
        countries.createCountry(fullName: "Papua New Guinea", shortName: "PNG", continent: "Ocenaia", flagIcon: "🇵🇬")
        countries.createCountry(fullName: "Samoa", shortName: "WSM", continent: "Ocenaia", flagIcon: "🇼🇸")
        countries.createCountry(fullName: "Solomon Islands", shortName: "SLB", continent: "Oceania", flagIcon: "🇸🇧")
        countries.createCountry(fullName: "Tonga", shortName: "TON", continent: "Oceania", flagIcon: "🇹🇴")
        countries.createCountry(fullName: "Tuvalu", shortName: "TUV", continent: "Oceania", flagIcon: "🇹🇻")
        countries.createCountry(fullName: "Vanuatu", shortName: "VUT", continent: "Ocenaia", flagIcon: "🇻🇺")
        
        //Africa
        countries.createCountry(fullName: "Algeria", shortName: "DZA", continent: "Africa", flagIcon: "🇩🇿")
        countries.createCountry(fullName: "Angola", shortName: "AGO", continent: "Africa", flagIcon: "🇦🇴")
        countries.createCountry(fullName: "Benin", shortName: "BEN", continent: "Africa", flagIcon: "🇧🇯")
        countries.createCountry(fullName: "Botswana", shortName: "BWA", continent: "Africa", flagIcon: "🇧🇼")
        countries.createCountry(fullName: "Burkina Faso", shortName: "BFA", continent: "Africa", flagIcon: "🇧🇫")
        countries.createCountry(fullName: "Burundi", shortName: "BDI", continent: "Africa", flagIcon: "🇧🇮")
        countries.createCountry(fullName: "Cameroon", shortName: "CMR", continent: "Africa", flagIcon: "🇨🇲")
        countries.createCountry(fullName: "Cape Verde", shortName: "CPV", continent: "Africa", flagIcon: "🇨🇻")
        countries.createCountry(fullName: "Central African Republic", shortName: "CAF", continent: "Africa", flagIcon: "🇨🇫")
        countries.createCountry(fullName: "Chad", shortName: "TCD", continent: "Africa", flagIcon: "🇹🇩")
        countries.createCountry(fullName: "Comoros", shortName: "COM", continent: "Africa", flagIcon: "🇰🇲")
        countries.createCountry(fullName: "Côte d'Ivoire", shortName: "CIV", continent: "Africa", flagIcon: "🇨🇮")
        countries.createCountry(fullName: "Democratic Republic of the Congo", shortName: "COD", continent: "Africa", flagIcon: "🇨🇩")
        countries.createCountry(fullName: "Djibouti", shortName: "DJI", continent: "Africa", flagIcon: "🇩🇯")
        countries.createCountry(fullName: "Egypt", shortName: "EGY", continent: "Africa", flagIcon: "🇪🇬")
        countries.createCountry(fullName: "Equatorial Guinea", shortName: "GNQ", continent: "Africa", flagIcon: "🇬🇶")
        countries.createCountry(fullName: "Eritrea", shortName: "ERI", continent: "Africa", flagIcon: "🇪🇷")
        countries.createCountry(fullName: "Eswatini", shortName: "SWZ", continent: "Africa", flagIcon: "🇸🇿")
        countries.createCountry(fullName: "Ethiopia", shortName: "ETH", continent: "Africa", flagIcon: "🇪🇹")
        countries.createCountry(fullName: "Gabon", shortName: "GAB", continent: "Africa", flagIcon: "🇬🇦")
        countries.createCountry(fullName: "Gambia", shortName: "GMB", continent: "Africa", flagIcon: "🇬🇲")
        countries.createCountry(fullName: "Ghana", shortName: "GHA", continent: "Africa", flagIcon: "🇬🇭")
        countries.createCountry(fullName: "Guinea", shortName: "GIN", continent: "Africa", flagIcon: "🇬🇳")
        countries.createCountry(fullName: "Guinea-Bissau", shortName: "GNB", continent: "Africa", flagIcon: "🇬🇼")
        countries.createCountry(fullName: "Kenya", shortName: "KEN", continent: "Africa", flagIcon: "🇰🇪")
        countries.createCountry(fullName: "Lesotho", shortName: "LSO", continent: "Africa", flagIcon: "🇱🇸")
        countries.createCountry(fullName: "Liberia", shortName: "LBR", continent: "Africa", flagIcon: "🇱🇷")
        countries.createCountry(fullName: "Libya", shortName: "LBY", continent: "Africa", flagIcon: "🇱🇾")
        countries.createCountry(fullName: "Madagascar", shortName: "MDG", continent: "Africa", flagIcon: "🇲🇬")
        countries.createCountry(fullName: "Malawi", shortName: "MWI", continent: "Africa", flagIcon: "🇲🇼")
        countries.createCountry(fullName: "Mali", shortName: "MLI", continent: "Africa", flagIcon: "🇲🇱")
        countries.createCountry(fullName: "Mauritania", shortName: "MRT", continent: "Africa", flagIcon: "🇲🇷")
        countries.createCountry(fullName: "Mauritius", shortName: "MUS", continent: "Africa", flagIcon: "🇲🇺")
        countries.createCountry(fullName: "Morocco", shortName: "MAR", continent: "Africa", flagIcon: "🇲🇦")
        countries.createCountry(fullName: "Mozambique", shortName: "MOZ", continent: "Africa", flagIcon: "🇲🇿")
        countries.createCountry(fullName: "Namibia", shortName: "NAM", continent: "Africa", flagIcon: "🇳🇦")
        countries.createCountry(fullName: "Niger", shortName: "NER", continent: "Africa", flagIcon: "🇳🇪")
        countries.createCountry(fullName: "Nigeria", shortName: "NGA", continent: "Africa", flagIcon: "🇳🇬")
        countries.createCountry(fullName: "Republic of the Congo", shortName: "COG", continent: "Africa", flagIcon: "🇨🇬")
        countries.createCountry(fullName: "Rwanda", shortName: "RWA", continent: "Africa", flagIcon: "🇷🇼")
        countries.createCountry(fullName: "São Tomé and Príncipe", shortName: "STP", continent: "Africa", flagIcon: "🇸🇹")
        countries.createCountry(fullName: "Senegal", shortName: "SEN", continent: "Africa", flagIcon: "🇸🇳")
        countries.createCountry(fullName: "Seychelles", shortName: "SYC", continent: "Africa", flagIcon: "🇸🇨")
        countries.createCountry(fullName: "Sierra Leone", shortName: "SLE", continent: "Africa", flagIcon: "🇸🇱")
        countries.createCountry(fullName: "Somalia", shortName: "SOM", continent: "Africa", flagIcon: "🇸🇴")
        countries.createCountry(fullName: "South Africa", shortName: "ZAF", continent: "Africa", flagIcon: "🇿🇦")
        countries.createCountry(fullName: "South Sudan", shortName: "SSD", continent: "Africa", flagIcon: "🇸🇸")
        countries.createCountry(fullName: "Sudan", shortName: "SDN", continent: "Africa", flagIcon: "🇸🇩")
        countries.createCountry(fullName: "Tanzania", shortName: "TZA", continent: "Africa", flagIcon: "🇹🇿")
        countries.createCountry(fullName: "Togo", shortName: "TGO", continent: "Africa", flagIcon: "🇹🇬")
        countries.createCountry(fullName: "Tunisia", shortName: "TUN", continent: "Africa", flagIcon: "🇹🇳")
        countries.createCountry(fullName: "Uganda", shortName: "UGA", continent: "Africa", flagIcon: "🇺🇬")
        countries.createCountry(fullName: "Zambia", shortName: "ZMB", continent: "Africa", flagIcon: "🇿🇲")
        countries.createCountry(fullName: "Zimbabwe", shortName: "ZWE", continent: "Africa", flagIcon: "🇿🇼")
        
        //South America
        countries.createCountry(fullName: "Argentina", shortName: "ARG", continent: "South America", flagIcon: "🇦🇷")
        countries.createCountry(fullName: "Bolivia", shortName: "BOL", continent: "South America", flagIcon: "🇧🇴")
        countries.createCountry(fullName: "Brazil", shortName: "BRA", continent: "South America", flagIcon: "🇧🇷")
        countries.createCountry(fullName: "Chile", shortName: "CHL", continent: "South America", flagIcon: "🇨🇱")
        countries.createCountry(fullName: "Colombia", shortName: "COL", continent: "South America", flagIcon: "🇨🇴")
        countries.createCountry(fullName: "Ecuador", shortName: "ECU", continent: "South America", flagIcon: "🇪🇨")
        countries.createCountry(fullName: "Guyana", shortName: "GUY", continent: "South America", flagIcon: "🇬🇾")
        countries.createCountry(fullName: "Paraguay", shortName: "PRY", continent: "South America", flagIcon: "🇵🇾")
        countries.createCountry(fullName: "Peru", shortName: "PER", continent: "South America", flagIcon: "🇵🇪")
        countries.createCountry(fullName: "Suriname", shortName: "SUR", continent: "South America", flagIcon: "🇸🇷")
        countries.createCountry(fullName: "Uruguay", shortName: "URY", continent: "South America", flagIcon: "🇺🇾")
        countries.createCountry(fullName: "Venezuela", shortName: "VEN", continent: "South America", flagIcon: "🇻🇪")
        
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
