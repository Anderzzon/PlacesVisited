//
//  CountriesTableViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-23.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit
import CoreData

class CountriesTableViewController: UITableViewController {
    
    let cellIdentity = "countryCell"
    var countries : ListOfCountries!
    
    private func continentsForSectionIndex(_ index: Int) -> ListOfCountries.Continents? {
        return ListOfCountries.Continents(rawValue: index)
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func SegmentBeenVsWant(_ sender: Any) {
        
        tableView.reloadData()
    }
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //White text on segment switcher:
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        
        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentity)
        
        tableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
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
                title = "Europe"
            case .NorthAmerica:
                title = "North America"
            case .SouthAmerica:
                title = "South America"
            case .Oceania:
                title = "Oceania (Australia)"
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
            switch segmentControl.selectedSegmentIndex {
            case 0:
                return countries.listOfCountries(for: continent).count
            case 1:
                return countries.listOfCountriesNotVisited(for: continent).count
            default:
                break
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as! CountryTableViewCell
        
        switch segmentControl.selectedSegmentIndex {
        case 0: //All countries
            
            if let continent = continentsForSectionIndex(indexPath.section) {
                let items = countries.listOfCountries(for: continent)
                let item = items[indexPath.row]
                
                cell.countryFullNameLabel?.text = item.fullName
                cell.flagLabel?.text = String(item.flagIcon)
                
                configureCheckmark(for: cell, with: item)
            }
        case 1: //Countries not visited
            if let continent = continentsForSectionIndex(indexPath.section) {
                let items = countries.listOfCountriesNotVisited(for: continent)
                let item = items[indexPath.row]
                
                cell.countryFullNameLabel?.text = item.fullName
                cell.flagLabel?.text = String(item.flagIcon)
                
                configureCheckmarkWantTo(for: cell, with: item)
            }
        default:
            break
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if let continent = continentsForSectionIndex(indexPath.section) {
                
                switch segmentControl.selectedSegmentIndex {
                case 0:
                    let items = countries.listOfCountries(for: continent)
                    let item = items[indexPath.row]
                    
                    countries.updateVisit(country: item, index: indexPath.row)
                    
                    configureCheckmark(for: cell, with: item)
                    item.updateMap = true
                    tableView.deselectRow(at: indexPath, animated: true)
                    tableView.reloadData()
                    
                case 1:
                    let items = countries.listOfCountriesNotVisited(for: continent)
                    let item = items[indexPath.row]
                    
                    countries.updateWantToGo(country: item, index: indexPath.row)
                    
                    configureCheckmarkWantTo(for: cell, with: item)
                    item.updateMap = true
                    tableView.deselectRow(at: indexPath, animated: true)
                    tableView.reloadData()
                    
                default:
                    break
                }
            }
        }
    }
    
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
    
    func configureCheckmarkWantTo(for cell: UITableViewCell, with item: Country) {
        guard let country = cell as? CountryTableViewCell else {
            return
        }
        if item.wantToGo == false {
            cell.accessoryType = .none
        } else if item.wantToGo == true {
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
