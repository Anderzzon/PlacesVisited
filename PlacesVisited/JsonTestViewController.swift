//
//  JsonTestViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-02-14.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class JsonTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let json = readJSONFromFile(fileName: "CountriesClean") as? [String : Any] {
            let c = CountryGeo(json: json )
            
            //print(c.name)
            //print(c.points)
        }
        
    }
    
    func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }


   

}
