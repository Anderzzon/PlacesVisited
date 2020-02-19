//
//  WorldMapViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-02-11.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit
import MapKit

class WorldMapViewController: UIViewController {
    
    var countries : ListOfCountries!
    var countryOverlays: [CountryGeo] = []
    var mkOverlays: [[MKOverlay]] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
                let location = CLLocation(latitude: 55.663255, longitude:   13.597545)
                let regionRadius: CLLocationDistance = 5000000.0
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                mapView.setRegion(region, animated: true)
        
        produceOverlay()
        //print(countries.listOfCountriesNotVisited(for: .Europe))
        //updateOverlayColors()
        print("Number of MKLayers: \(mkOverlays.count)")

    }
    
    func updateOverlayColors() {
        let visitedOverlay = countryOverlays[0].polygons
        visitedOverlay[0].identifier = "visited"
        
        
        for overlay in mapView.overlays {
            if let renderer = mapView.renderer(for: overlay) as? MKPolygonRenderer {
                configureColor(of: renderer, for: overlay)
            }
        }
    }
    
    private func produceOverlay() {
        
        //Read json:
        if let json = readJSONFromFile(fileName: "countries") as? [[String : Any]] {
            
            //Loop through json and append countries to array of countryOverlays:
            for co in json {
                
                let country = CountryGeo(json: co )
            
                countryOverlays.append(country)
                
            }
            
            var allCountries: [Country] = []
            var continentCountries = countries.listOfCountries(for: .Europe)
            
            for country in 0 ..< continentCountries.count {
                let country = continentCountries[country]
                allCountries.append(country)
            }
            //Loop through countryOverlays and set the overlays identifyer to the correspeonding countrys status:
            for country in 0 ..< allCountries.count {
                
                for i in 0 ..< countryOverlays.count {
                    
                    let overlay = countryOverlays[i].polygons
                    
                    print("Antalet lager för \(countryOverlays[i].isoA3) är \(overlay.count)")
                    print("Antalet länder-lager är \(countryOverlays.count)")
                    print("i är: \(i)")
                    
                    mkOverlays.append(overlay)
                    
                    if countryOverlays[i].isoA3 == allCountries[country].shortName {
                        var identifier = ""
                        if allCountries[country].visited == true {
                            identifier = "visited"
                        } else if allCountries[country].wantToGo {
                            identifier = "wantToGo"
                        }
                        for j in 0..<overlay.count {
                            //let visitedOverlay = countryOverlays[i].polygons
                            overlay[j].identifier = identifier
                            print("\(countryOverlays[i].isoA3):s lager är satt till: \(overlay[j].identifier)")
                        }
                        
                        mapView.addOverlays(overlay, level: .aboveRoads)
                    }
//                    } else if countryOverlays[i].isoA3 == "CYM"{
//                        for j in 0..<overlay.count {
//                            //let visitedOverlay = countryOverlays[i].polygons
//                            overlay[j].identifier = "wantToGo"
//                            print("\(countryOverlays[i].isoA3):s lager är satt till: \(overlay[j].identifier)")
//                        }
//
//                        mapView.addOverlays(overlay, level: .aboveRoads)
//                    }
                    else {
                        
                        mapView.addOverlays(overlay, level: .aboveRoads)
                    }
                    print("Adding layer for country \(countryOverlays[i].isoA3)")
                }
            }
            

            
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
    
    func configureColor(of renderer: MKPolygonRenderer, for overlay: MKOverlay) {
        let fillColor: UIColor
        if let polygon = overlay as? CustomPolygon, polygon.identifier == "visited" {
            fillColor = .green
        } else if let polygon = overlay as? CustomPolygon, polygon.identifier == "wantToGo" {
            fillColor = .yellow
        } else {
            fillColor = .red
        }
        renderer.fillColor = fillColor.withAlphaComponent(0.8)
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

extension WorldMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolygonRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.black
        //renderer.fillColor = UIColor.green
        //renderer.fillColor = variables.fillColor
        configureColor(of: renderer, for: overlay)
        renderer.lineWidth = 0.3
        
        print("rendering layer")
        return renderer
        
    }
    
}


