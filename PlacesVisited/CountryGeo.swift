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
        print(type)
        
        switch type {
        case "Polygon":
            let coordinates = geometry?["coordinates"] as? [Any]
            
            let polygons = coordinates?[0] as? [Any]
            
            for coord in polygons! {
                let c = coord as? [Double]
                
                //let co = CLLocationCoordinate2D(latitude: (c?[0])!, longitude: (c?[1])!)
                
                //            let co = CLLocationCoordinate2DMake((c?[0])!, (c?[1])!)
                
                //let co = [c?[0], c?[1]]
                
                points.append(CLLocationCoordinate2DMake((c?[1])!, (c?[0])!))
                //print(co)
                
                //print(points)
                
            }
            let polygon = CustomPolygon(coordinates: &points, count: points.count)
            //let polygon = CustomPolygon(coordinates: &points, count: 3)
            
            self.polygons.append(polygon)
        case "MultiPolygon":
            

            let coordinates = geometry?["coordinates"] as! [Any]
            
            
            for geo in coordinates {
                let geo = geo as! [Any]
                let g2 = geo[0] as! [Any]
 
                var pointsToAdd: [CLLocationCoordinate2D] = []
                
                for coord in g2 {
                    //print("Looping coordinates")
                    
                    let c = coord as! [Double]
                    
                  //  let c2 = c![0] as! [Double]
                    //let co = [c?[0], c?[1]]
                    
                    
                    pointsToAdd.append(CLLocationCoordinate2DMake((c[1]), (c[0])))
                    //print(co)
                    
                    //print(points)
                    
                }
                let polygon = CustomPolygon(coordinates: &pointsToAdd, count: pointsToAdd.count)
                //let polygon = CustomPolygon(coordinates: &pointsToAdd, count: 3)
                //print("Making MKPolygon")
                if pointsToAdd.count > 80 {
                
                self.polygons.append(polygon)
                }
                //print("Adding MKPolygon to array")
                
            }
            
            
            
            
            
            
            //let multiPolygons = coordinates?[0] as? [Any]
            
            //var pointsToAdd: [CLLocationCoordinate2D] = []
//
//            for geo in multiPolygons! {
//                print("Looping polygons")
//
//                let polygons = geo as? [Any]
//
//                for coord in polygons! {
//                    print("Looping coordinates")
//
//                    let c = coord as? [Double]
//
//                    //let co = [c?[0], c?[1]]
//
//                    pointsToAdd.append(CLLocationCoordinate2DMake((c?[1])!, (c?[0])!))
//                    //print(co)
//
//                    //print(points)
//
//                }

            //}
        default:
            break
        }
        
        
        
    }
    
    
    
    
}
