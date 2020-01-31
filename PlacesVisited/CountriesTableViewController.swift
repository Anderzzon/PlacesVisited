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
    //var countries: ListOfCountries
    
    private func continentsForSectionIndex(_ index: Int) -> ListOfCountries.Continents? {
        return ListOfCountries.Continents(rawValue: index)
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func SegmentBeenVsWant(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //let managedContext = appDelegate!.persistentContainer.viewContext
        
        //countries = ListOfCountries(context: managedContext)
        
        countries.loadItems()
        
     //   countries.createCountry(fullName:"Sweden", shortName:"Swe", continent:"Europe", flagIcon:"🇸🇪")
      //  countries.createCountry(fullName:"China", shortName:"CHI", continent:"Asia", flagIcon:"🇨🇳")
        
        
        
        //White text on segment switcher:
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        
//        countries.add(country: Country(short: "DEN", name: "Denmark", continent: "Europe", flagIcon: "🇩🇰"), for: .Europe)
//        countries.add(country: Country(short: "USA", name: "USA", continent: "North America", flagIcon: "🇺🇸"), for: .NorthAmerica)
//        countries.add(country: Country(short: "FRA", name: "France", continent: "Europe", flagIcon: "🇫🇷"), for: .Europe)
//        countries.add(country: Country(short: "THI", name: "Thailand", continent: "Asia", flagIcon: "🇹🇭"), for: .Asia)
//
//        countries.add(country: Country(short: "CHI", name: "China", continent: "Asia", flagIcon: "🇨🇳"), for: .Asia)
//        countries.add(country: Country(short: "FIN", name: "Finland", continent: "Europe", flagIcon: "🇫🇮"), for: .Europe)
//        countries.add(country: Country(short: "GER", name: "Germany", continent: "Europe", flagIcon: "🇩🇪"), for: .Europe)
//        countries.add(country: Country(short: "AUS", name: "Australia", continent: "Australia", flagIcon: "🇦🇺"), for: .Oceania)
//        countries.add(country: Country(short: "GRE", name: "Greece", continent: "Europe", flagIcon: "🇬🇷"), for: .Europe)
//        countries.add(country: Country(short: "BEL", name: "Belgium", continent: "Europe", flagIcon: "🇧🇪"), for: .Europe)
//        countries.add(country: Country(short: "SOA", name: "South Africa", continent: "Africa", flagIcon: "🇿🇦"), for: .Africa)
//        countries.add(country: Country(short: "EGY", name: "Egypt", continent: "Africa", flagIcon: "🇪🇬"), for: .Africa)
//        countries.add(country: Country(short: "SIN", name: "Singapore", continent: "Africa", flagIcon: "🇸🇬"), for: .Asia)
//        countries.add(country: Country(short: "BRZ", name: "Brazil", continent: "South America", flagIcon: "🇧🇷"), for: .SouthAmerica)
//        countries.add(country: Country(short: "PRU", name: "Peru", continent: "South America", flagIcon: "🇵🇪"), for: .SouthAmerica)
//        countries.add(country: Country(short: "ARG", name: "Argentina", continent: "South America", flagIcon: "🇦🇷"), for: .SouthAmerica)
//        countries.add(country: Country(short: "MEX", name: "Mexico", continent: "Notrh America", flagIcon: "🇲🇽"), for: .NorthAmerica)
//        countries.add(country: Country(short: "CAN", name: "Canada", continent: "Notrh America", flagIcon: "🇨🇦"), for: .NorthAmerica)

        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentity)
        
        tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countries.loadItems()
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ListOfCountries.Continents.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        if let continent = continentsForSectionIndex(section) {
            //let percentVisited: Int = Int(countries.percentOfContinentVisited(for: continent))
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
                
                //configureCheckmark(for: cell, with: item)
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
                        
                        item.toggleVisited()
                        
                        configureCheckmark(for: cell, with: item)
                        tableView.deselectRow(at: indexPath, animated: true)
                        tableView.reloadData()
                        
                        
                        print(item.visited)
                        print(countries.numberOfCountriesNotVisited)
//                        var world = countries.percentOfWorldVisited()
//                        var progress = countries.bucketListProgress()
                        
                        
                    case 1:
                        let items = countries.listOfCountriesNotVisited(for: continent)
                        let item = items[indexPath.row]
                        
                        item.toggleWantToGo()
                        
                        configureCheckmarkWantTo(for: cell, with: item)
                        tableView.deselectRow(at: indexPath, animated: true)
                        
                        print(item.visited)
                        print(countries.numberOfCountriesNotVisited)
//                        var world = countries.percentOfWorldVisited()
//                        var progress = countries.bucketListProgress()
                        
                    default:
                        break
                    }
                    
                    
                    //Old visited function
//                    if item.visited == false {
//                        item.visitCountry(visit: true)
//                        configureCheckmark(for: cell, with: item)
//                        tableView.deselectRow(at: indexPath, animated: true)
//                    } else {
//                        item.visitCountry(visit: false)
//                    }
                    
                    
                    
                    
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
    
//    func loadCountries() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<Country>(entityName: "Country")
//
//        do {
//            countries = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch \(error)")
//        }
//    }
    

    

   
    

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
