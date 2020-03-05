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
    var isoA3 : String?
    var points: [CLLocationCoordinate2D] = []
    var polygons: [CustomPolygon] = []
    
    init(json: [String: Any]) {
        
        let property = json["properties"] as? [String : Any]
        
        isoA3 = property?["ISO_A3"] as? String
        
        let geometry = json["geometry"] as? [String : Any]
        
        let type = geometry?["type"] as? String
        
        switch type {
        case "Polygon":
            let coordinates = geometry?["coordinates"] as? [Any]
            
            let polygons = coordinates?[0] as? [Any]
            
            for coordinate in polygons! {
                let lngLat = coordinate as? [Double]
                
                points.append(CLLocationCoordinate2DMake((lngLat?[1])!, (lngLat?[0])!))
                
            }
            let polygon = CustomPolygon(coordinates: &points, count: points.count)
            
            self.polygons.append(polygon)
        case "MultiPolygon":
            
            let coordinates = geometry?["coordinates"] as! [Any]
            
            for geografic in coordinates {
                let geo = geografic as! [Any]
                let arrayOfCoordinates = geo[0] as! [Any]
                
                var pointsToAdd: [CLLocationCoordinate2D] = []
                
                for coordinate in arrayOfCoordinates {
                    
                    let lngLat = coordinate as! [Double]
                    
                    pointsToAdd.append(CLLocationCoordinate2DMake((lngLat[1]), (lngLat[0])))
                    
                }
                let polygon = CustomPolygon(coordinates: &pointsToAdd, count: pointsToAdd.count)
                if pointsToAdd.count > 70 {
                    
                    self.polygons.append(polygon)
                }
            }
            
        default:
            break
        }
    }
}
