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

            var outerPoints: [CLLocationCoordinate2D] = []
            for coordinate in (coordinates?[0] as? [Any]) ?? [] {
                let lngLat = coordinate as? [Double]
                outerPoints.append(CLLocationCoordinate2DMake((lngLat?[1])!, (lngLat?[0])!))
            }

            var holes: [MKPolygon] = []
            if let rings = coordinates, rings.count > 1 {
                for i in 1..<rings.count {
                    var innerPoints: [CLLocationCoordinate2D] = []
                    for coordinate in (rings[i] as? [Any]) ?? [] {
                        let lngLat = coordinate as? [Double]
                        innerPoints.append(CLLocationCoordinate2DMake((lngLat?[1])!, (lngLat?[0])!))
                    }
                    if !innerPoints.isEmpty {
                        holes.append(MKPolygon(coordinates: &innerPoints, count: innerPoints.count))
                    }
                }
            }

            let polygon = CustomPolygon(coordinates: &outerPoints, count: outerPoints.count,
                                        interiorPolygons: holes.isEmpty ? nil : holes)
            polygon.hasHoles = !holes.isEmpty
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

                var holes: [MKPolygon] = []
                if geo.count > 1 {
                    for i in 1..<geo.count {
                        var innerPoints: [CLLocationCoordinate2D] = []
                        for coordinate in (geo[i] as! [Any]) {
                            let lngLat = coordinate as! [Double]
                            innerPoints.append(CLLocationCoordinate2DMake((lngLat[1]), (lngLat[0])))
                        }
                        holes.append(MKPolygon(coordinates: &innerPoints, count: innerPoints.count))
                    }
                }

                if pointsToAdd.count > 50 {
                    let polygon = CustomPolygon(coordinates: &pointsToAdd, count: pointsToAdd.count,
                                                interiorPolygons: holes.isEmpty ? nil : holes)
                    polygon.hasHoles = !holes.isEmpty
                    self.polygons.append(polygon)
                }
            }
            
        default:
            break
        }
    }
}
