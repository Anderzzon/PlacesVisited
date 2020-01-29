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
    
    var recivingArrey: ListOfCountries?

    override func viewDidLoad() {
        super.viewDidLoad()

        percentOfWorld.text = " %"
        
        print(recivingArrey?.percentOfWorldVisited())
        
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
