//
//  CountryDetailViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-02-27.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    var countryToUpdate: String!
    var countries: ListOfCountries!
    var label = ""
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var visitLabel: UILabel!
    @IBOutlet weak var wantToGoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelFromCountry()
        countryName.text = label
 
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateVisitForAll() {
        updateVisitForCountry(for: .Europe)
        updateVisitForCountry(for: .Asia)
        updateVisitForCountry(for: .Africa)
        updateVisitForCountry(for: .NorthAmerica)
        updateVisitForCountry(for: .SouthAmerica)
        updateVisitForCountry(for: .Oceania)
    }
    
    func updateWantToGoForAll() {
        updateWantToGoForCountry(for: .Europe)
        updateWantToGoForCountry(for: .Asia)
        updateWantToGoForCountry(for: .Africa)
        updateWantToGoForCountry(for: .NorthAmerica)
        updateWantToGoForCountry(for: .SouthAmerica)
        updateWantToGoForCountry(for: .Oceania)
    }

    func updateVisitForCountry(for continent: ListOfCountries.Continents) {
    
    let countriesToLoop = countries.listOfCountries(for: continent)
        for country in countriesToLoop {
            if country.shortName == countryToUpdate {
                print("Match on \(country.fullName)")
                countries.updateVisit(country: country, index: nil)
                country.toggleVisited()
                country.updateMap = true
                //
                
            }
        }
    }
    
    func updateWantToGoForCountry(for continent: ListOfCountries.Continents) {
    
    let countriesToLoop = self.countries.listOfCountries(for: continent)
    
        for country in countriesToLoop {
            if country.shortName == countryToUpdate {
                country.toggleVisited()
                country.updateMap = true
            }
        }
    }
    
    func setLabelFromCountry() {
        setLabel(for: .Europe)
        setLabel(for: .Asia)
        setLabel(for: .Africa)
        setLabel(for: .NorthAmerica)
        setLabel(for: .SouthAmerica)
        setLabel(for: .Oceania)
    }
    
    func setLabel(for continent: ListOfCountries.Continents) {
    
    let countriesToLoop = self.countries.listOfCountries(for: continent)
    
        for country in countriesToLoop {
            if country.shortName == countryToUpdate {
                label = country.fullName
            }
        }
    }
    
    @IBAction func visitButton(_ sender: UIButton) {
        updateVisitForAll()
    }
    
    
    @IBAction func wantToGoButton(_ sender: UIButton) {
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
