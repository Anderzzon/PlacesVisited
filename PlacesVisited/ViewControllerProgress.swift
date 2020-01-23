//
//  ViewControllerProgress.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-16.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class ViewControllerProgress: UIViewController {
    
    @IBOutlet weak var percentOfWorld: UILabel!
    
    var recivingArrey: [Country]?

    override func viewDidLoad() {
        super.viewDidLoad()

        let percentOfCountriesVisited = percentageOFWorld()
        percentOfWorld.text = "\(percentOfCountriesVisited) %"
        
        //print(recivingArrey![0].visited)
        
    }
    
    func percentageOFWorld() -> Double {
        var visitedCountries = 0
        var percent:Double
        
        for index in 1...recivingArrey!.count {
            if recivingArrey![index-1].visited == true {
                visitedCountries += 1
            }
        }
        percent = Double(visitedCountries) / Double(recivingArrey!.count)
        percent = percent*100
        percent = Double(round(10*percent)/10)
        
        print(visitedCountries)
        print(percent)
        
        return percent
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
