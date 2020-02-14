//
//  CountryGeo.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-02-14.
//  Copyright © 2020 Erik. All rights reserved.
//

import Foundation
import MapKit

class CountryGeo {
    var name : String?
    var points: [CLLocationCoordinate2D] = []
    
    
    init(json: [String: Any]) {
        let property = json["properties"] as? [String : Any]
              
        name = property?["ADMIN"] as? String
        
        let geometry = json["geometry"] as? [String : Any]
        
        let coordinates = geometry?["coordinates"] as? [Any]
        
        let polygons = coordinates?[0] as? [Any]
        
        
        
        
        for coord in polygons! {
            let c = coord as? [Double]
            
            //let co = CLLocationCoordinate2D(latitude: (c?[0])!, longitude: (c?[1])!)
            
//            let co = CLLocationCoordinate2DMake((c?[0])!, (c?[1])!)
            
            let co = [c?[0], c?[1]]
            
            points.append(CLLocationCoordinate2DMake((c?[1])!, (c?[0])!))
            print(co)
        }

        
    }
    
    func borderPoints() -> MKPolygon {

        let borderPoints = MKPolygon(coordinates: &points, count: points.count)
        return borderPoints
    }
    
    
}
