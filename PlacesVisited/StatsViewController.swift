//
//  StatsViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-30.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var countries : ListOfCountries!
    
    @IBOutlet weak var percentOfBucketListProgress: UILabel!
    
    @IBOutlet weak var bucketListCount: UILabel!
    
    
    private func continentsForSectionIndex(_ index: Int) -> ListOfCountries.Continents? {
        return ListOfCountries.Continents(rawValue: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries.loadItems()
        print(countries.percentOfWorldVisited())
        
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countries.loadItems()
        percentOfBucketListProgress.text = "\(countries.bucketListProgress())%"
        bucketListCount.text = "\(countries.numberOfCountriesWantToGoTo) more to go"
        
        //var percentVisited = countries.percentOfWorldVisited()
        //percentOfWorldVisited.text = "You have visited \(percentVisited) of the world"
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
