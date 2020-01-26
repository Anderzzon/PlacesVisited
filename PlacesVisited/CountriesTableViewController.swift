//
//  CountriesTableViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-23.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    let cellIdentity = "countryCell"
    var countries = ListOfCountries()
    //var countries: ListOfCountries
    
    private func continentsForSectionIndex(_ index: Int) -> ListOfCountries.Continents? {
        return ListOfCountries.Continents(rawValue: index)
    }

    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title in nav bar:
        navBar.topItem?.title = "Countries"
        
        countries.add(country: Country(short: "SWE", name: "Sweden", continent: "Europe", flagIcon: "🇸🇪"), for: .Europe)
        countries.add(country: Country(short: "DEN", name: "Denmark", continent: "Europe", flagIcon: "🇩🇰"), for: .Europe)
        countries.add(country: Country(short: "USA", name: "USA", continent: "North America", flagIcon: "🇺🇸"), for: .NorthAmerica)
        countries.add(country: Country(short: "FRA", name: "France", continent: "Europe", flagIcon: "🇫🇷"), for: .Europe)
        countries.add(country: Country(short: "THI", name: "Thailand", continent: "Asia", flagIcon: "🇹🇭"), for: .Asia)
        
        countries.add(country: Country(short: "CHI", name: "China", continent: "Asia", flagIcon: "🇨🇳"), for: .Asia)
        countries.add(country: Country(short: "FIN", name: "Finland", continent: "Europe", flagIcon: "🇫🇮"), for: .Europe)
        countries.add(country: Country(short: "GER", name: "Germany", continent: "Europe", flagIcon: "🇩🇪"), for: .Europe)
        countries.add(country: Country(short: "AUS", name: "Australia", continent: "Australia", flagIcon: "🇦🇺"), for: .Africa)
        countries.add(country: Country(short: "GRE", name: "Greece", continent: "Europe", flagIcon: "🇬🇷"), for: .Europe)
        countries.add(country: Country(short: "BEL", name: "Belgium", continent: "Europe", flagIcon: "🇧🇪"), for: .Europe)

        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentity)
        
        tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ListOfCountries.Continents.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        if let continent = continentsForSectionIndex(section) {
            switch continent {
            case .Africa:
                title = "Africa"
            case .Asia:
                title = "Asia"
            case .Europe:
                title = "Asia"
            case .NorthAmerica:
                title = "North America"
            }
        }
        return title
    }
    
    //Use this for letter index on right side of table view:
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return UILocalizedIndexedCollation.current().sectionTitles
//    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }

    //Number of rows in each section:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let continent = continentsForSectionIndex(section) {
            return countries.listOfCountries(for: continent).count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as! CountryTableViewCell
            
            if let continent = continentsForSectionIndex(indexPath.section) {
                let items = countries.listOfCountries(for: continent)
                let item = items[indexPath.row]
                
                
                cell.countryFullNameLabel?.text = item.fullName
                cell.flagLabel?.text = String(item.flagIcon)
                //Fix this - Fixed?:
                configureCheckmark(for: cell, with: item)
            }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if countries.showCountry(index: indexPath.row)?.visited == false {
//                countries.visitCountry(index: indexPath.row, visit: true) //Updates the Country
//                configureCheckmark(for: cell, at: indexPath)
//                tableView.deselectRow(at: indexPath, animated: true)
//            } else {
//                countries.visitCountry(index: indexPath.row, visit: false) //Updates the Country
//                configureCheckmark(for: cell, at: indexPath)
//                tableView.deselectRow(at: indexPath, animated: true)
//            }
//        }
//
//    }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                if let continent = continentsForSectionIndex(indexPath.section) {
                    let items = countries.listOfCountries(for: continent)
                    var item = items[indexPath.row]
                    
                    //item.toggleVisited()
                    if item.visited == false {
                        item.visitCountry(visit: true)
                        configureCheckmark(for: cell, with: item)
                        tableView.deselectRow(at: indexPath, animated: true)
                    } else {
                        item.visitCountry(visit: false)
                    }
                    
                    configureCheckmark(for: cell, with: item)
                    tableView.deselectRow(at: indexPath, animated: true)
                    print(item.visited)
                }
            }
        }
    
      //Old configureCheckmark function:
//    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
//
//            if countries.showCountry(index: indexPath.row)?.visited == false {
//                cell.accessoryType = .none
//            } else {
//                cell.accessoryType = .checkmark
//            }
//        }
    
    //New configureCheckmark function:
    func configureCheckmark(for cell: UITableViewCell, with item: Country) {
        guard let country = cell as? CountryTableViewCell else {
            return
        }
        if item.visited == false {
            cell.accessoryType = .none
        } else if item.visited == true {
            cell.accessoryType = .checkmark
            }
    }
    
   
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
