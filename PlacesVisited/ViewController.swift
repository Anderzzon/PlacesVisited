//
//  ViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-16.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let seguId = "segToViewControllerProgress"
    var listOfCountries = [Country]()


    //Buttons
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
            

    override func viewDidLoad() {
        super.viewDidLoad()
        setCountries()
        // Do any additional setup after loading the view.
    }

    func setCountries(){
        listOfCountries.append(Country(short: "SWE", name: "Sweden", continent: "Europe", flagIcon: "🇸🇪"))
        listOfCountries.append(Country(short: "DEN", name: "Denmark", continent: "Europe", flagIcon: "🇸🇪"))
        listOfCountries.append(Country(short: "USA", name: "USA", continent: "North America", flagIcon: "🇸🇪"))
        listOfCountries.append(Country(short: "FRA", name: "France", continent: "Europe", flagIcon: "🇸🇪"))
        listOfCountries.append(Country(short: "THI", name: "Thailand", continent: "Asia",flagIcon: "🇸🇪"))
        listOfCountries.append(Country(short: "CHI", name: "China", continent: "Asia",flagIcon: "🇸🇪"))
        listOfCountries.append(Country(short: "FIN", name: "Finland", continent: "Europe",flagIcon: "🇸🇪"))
        
        button0.setTitle(listOfCountries[0].fullName, for: .normal)
        button1.setTitle(listOfCountries[1].fullName, for: .normal)
        button2.setTitle(listOfCountries[2].fullName, for: .normal)
        button3.setTitle(listOfCountries[3].fullName, for: .normal)
        button4.setTitle(listOfCountries[4].fullName, for: .normal)
        button5.setTitle(listOfCountries[5].fullName, for: .normal)
        button6.setTitle(listOfCountries[6].fullName, for: .normal)
    }

    @IBAction func button0Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 0)
        if listOfCountries[0].visited == true {
            button0.backgroundColor = UIColor.green
        } else {
            button0.backgroundColor = UIColor.clear
        }
        
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 1)
        if listOfCountries[1].visited == true {
            button1.backgroundColor = UIColor.green
        } else {
            button1.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 2)
        if listOfCountries[2].visited == true {
            button2.backgroundColor = UIColor.green
        } else {
            button2.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func button3Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 3)
        if listOfCountries[3].visited == true {
            button3.backgroundColor = UIColor.green
        } else {
            button3.backgroundColor = UIColor.clear
        }
    }
    @IBAction func button4Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 4)
        if listOfCountries[4].visited == true {
            button4.backgroundColor = UIColor.green
        } else {
            button4.backgroundColor = UIColor.clear
        }
    }
    @IBAction func button5Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 5)
        if listOfCountries[5].visited == true {
            button5.backgroundColor = UIColor.green
        } else {
            button5.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func button6Pressed(_ sender: UIButton) {
        setVisitedCountry(countryIndex: 6)
        if listOfCountries[6].visited == true {
            button6.backgroundColor = UIColor.green
        } else {
            button6.backgroundColor = UIColor.clear
        }
    }
    
    func setVisitedCountry(countryIndex: Int) {
        
        if listOfCountries[countryIndex].visited == false {
            listOfCountries[countryIndex].visited = true
            print("Du har nu besökt \(listOfCountries[countryIndex].fullName)")
        } else {
            listOfCountries[countryIndex].visited = false
            print("Du har inte besökt \(listOfCountries[countryIndex].fullName)")
        }
    }
    
    @IBAction func progressButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: seguId, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguId {
            let destinationVC = segue.destination as! ViewControllerProgress
            
            //destinationVC.recivingArrey = listOfCountries
            
        }
    }
    
    @IBAction func returnToListOfCountries(_ segue: UIStoryboardSegue) {
    }
    
    
}

