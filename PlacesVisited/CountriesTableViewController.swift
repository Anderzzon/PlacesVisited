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

    @IBOutlet weak var navBar: UINavigationBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title in nav bar:
        navBar.topItem?.title = "Countries"
        
        countries.add(country: Country(short: "SWE", name: "Sweden", continent: "Europe", flagIcon: "🇸🇪"))
        countries.add(country: Country(short: "DEN", name: "Denmark", continent: "Europe", flagIcon: "🇩🇰"))
        countries.add(country: Country(short: "USA", name: "USA", continent: "North America", flagIcon: "🇺🇸"))
        countries.add(country: Country(short: "FRA", name: "France", continent: "Europe", flagIcon: "🇫🇷"))
        countries.add(country: Country(short: "THI", name: "Thailand", continent: "Asia", flagIcon: "🇹🇭"))
        countries.add(country: Country(short: "CHI", name: "China", continent: "Asia", flagIcon: "🇨🇳"))
        countries.add(country: Country(short: "FIN", name: "Finland", continent: "Europe", flagIcon: "🇫🇮"))
        countries.add(country: Country(short: "GER", name: "Germany", continent: "Europe", flagIcon: "🇩🇪"))
        countries.add(country: Country(short: "AUS", name: "Australia", continent: "Australia", flagIcon: "🇦🇺"))
        countries.add(country: Country(short: "GRE", name: "Greece", continent: "Europe", flagIcon: "🇬🇷"))
        countries.add(country: Country(short: "BEL", name: "Belgium", continent: "Europe", flagIcon: "🇧🇪"))
        countries.add(country: Country(short: "SWE", name: "Sweden", continent: "Europe", flagIcon: "🇸🇪"))
        countries.add(country: Country(short: "DEN", name: "Denmark", continent: "Europe", flagIcon: "🇩🇰"))
        countries.add(country: Country(short: "USA", name: "USA", continent: "North America", flagIcon: "🇺🇸"))
        countries.add(country: Country(short: "FRA", name: "France", continent: "Europe", flagIcon: "🇫🇷"))
        countries.add(country: Country(short: "THI", name: "Thailand", continent: "Asia", flagIcon: "🇹🇭"))
        countries.add(country: Country(short: "CHI", name: "China", continent: "Asia", flagIcon: "🇨🇳"))
        countries.add(country: Country(short: "FIN", name: "Finland", continent: "Europe", flagIcon: "🇫🇮"))
        countries.add(country: Country(short: "GER", name: "Germany", continent: "Europe", flagIcon: "🇩🇪"))
        countries.add(country: Country(short: "AUS", name: "Australia", continent: "Australia", flagIcon: "🇦🇺"))
        countries.add(country: Country(short: "GRE", name: "Greece", continent: "Europe", flagIcon: "🇬🇷"))
        countries.add(country: Country(short: "BEL", name: "Belgium", continent: "Europe", flagIcon: "🇧🇪"))
        countries.add(country: Country(short: "SWE", name: "Sweden", continent: "Europe", flagIcon: "🇸🇪"))
        countries.add(country: Country(short: "DEN", name: "Denmark", continent: "Europe", flagIcon: "🇩🇰"))
        countries.add(country: Country(short: "USA", name: "USA", continent: "North America", flagIcon: "🇺🇸"))
        countries.add(country: Country(short: "FRA", name: "France", continent: "Europe", flagIcon: "🇫🇷"))
        countries.add(country: Country(short: "THI", name: "Thailand", continent: "Asia", flagIcon: "🇹🇭"))
        countries.add(country: Country(short: "CHI", name: "China", continent: "Asia", flagIcon: "🇨🇳"))
        countries.add(country: Country(short: "FIN", name: "Finland", continent: "Europe", flagIcon: "🇫🇮"))
        countries.add(country: Country(short: "GER", name: "Germany", continent: "Europe", flagIcon: "🇩🇪"))
        countries.add(country: Country(short: "AUS", name: "Australia", continent: "Australia", flagIcon: "🇦🇺"))
        countries.add(country: Country(short: "GRE", name: "Greece", continent: "Europe", flagIcon: "🇬🇷"))
        countries.add(country: Country(short: "BEL", name: "Belgium", continent: "Europe", flagIcon: "🇧🇪"))

        
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as! CountryTableViewCell

        // Configure the cell:
        
        if let country = countries.showCountry(index: indexPath.row) {
            cell.countryFullNameLabel?.text = country.fullName
            cell.flagLabel?.text = String(country.flagIcon)
        }

        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            countries.visitCountry(index: indexPath.row, visit: true) //Updates the Country
            configureCheckmark(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
        
        
        print(countries.showCountry(index: indexPath.row)?.fullName)
        
        print(countries.showCountry(index: indexPath.row)?.visited)
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        
            if countries.showCountry(index: indexPath.row)?.visited == false {
                cell.accessoryType = .none
            } else {
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
