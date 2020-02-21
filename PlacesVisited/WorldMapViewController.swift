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
    
    var overlayDict = [String: CountryGeo]()
    var mkOverlaysDict = [String: [MKOverlay]]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
                let location = CLLocation(latitude: 55.663255, longitude:   13.597545)
                let regionRadius: CLLocationDistance = 5000000.0
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                mapView.setRegion(region, animated: true)
        mapView.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 2500000.0, maxCenterCoordinateDistance: 100000000.0), animated: true)
        
        readJson()
        produceOverlay()
        updateallOverlays()

        //renderOverlayToMap()
        renderOverlayToMapFromDict()
        
        //print(countries.listOfCountriesNotVisited(for: .Europe))
        //updateOverlayColors()
        print("Number of MKLayers: \(mkOverlays.count)")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        renderOverlayToMapFromDict()
    }
    
    
    //Not used:
    func updateOverlayColors() {
        
        
        let visitedOverlay = countryOverlays[0].polygons
        visitedOverlay[0].identifier = "visited"
        
        for overlay in mapView.overlays {
            if let renderer = mapView.renderer(for: overlay) as? MKPolygonRenderer {
                configureColor(of: renderer, for: overlay)
            }
        }
    }
    
    private func readJson() {
        //Read json:
        if let json = readJSONFromFile(fileName: "allCountries") as? [[String : Any]] {

            //Loop through json and append countries to array of countryOverlays:
            for co in json {
                
                let country = CountryGeo(json: co )
            
                countryOverlays.append(country)
                overlayDict[country.isoA3!] = country
            }
        }
    }
    
    private func produceOverlay() {
        //Old array loop:
//        for i in 0 ..< self.countryOverlays.count {
//
//            let overlay = self.countryOverlays[i].polygons
//            self.mkOverlays.append(overlay)
//        }
        
        //New Dictionary loop:
        for (_, value) in overlayDict {
            let overlay = value.polygons
            mkOverlaysDict[value.isoA3!] = overlay
        }
    }
    
    private func updateallOverlays() {
                let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
                dispatchQueue.async{
                    //Time consuming task here:
                    self.updateOverlay(for: .Europe)
                    self.updateOverlay(for: .Asia)
                    self.updateOverlay(for: .SouthAmerica)
                    self.updateOverlay(for: .NorthAmerica)
                    self.updateOverlay(for: .Oceania)
                    self.updateOverlay(for: .Africa)
        }
    }
    
    private func updateOverlay(for continent: ListOfCountries.Continents) {
        
        let countriesToLoop = self.countries.listOfCountries(for: continent)
        
        //Loop through countryOverlays and set the overlays identifyer to the correspeonding countrys status:
        for country in countriesToLoop {
            
            //New Dictinoary loop:
            guard let overlays = overlayDict[country.shortName]?.polygons else { break }
                
                //if value.isoA3 == countries[country].shortName {
                    var identifier = ""
                    if country.visited == true {
                        identifier = "visited"
                        print("Visited: \(country.fullName)")
                        //self.mkOverlays.append(overlay)
                    } else if country.wantToGo == true {
                        identifier = "wantToGo"
                        print("Want to go to: \(country.fullName)")
                        //self.mkOverlays.append(overlay)
                    }
                    
                    for overlay in overlays {
                        //let visitedOverlay = countryOverlays[i].polygons
                        overlay.identifier = identifier
                        print("Full name: \(overlayDict[country.shortName]?.isoA3) Identifier: \(overlay.identifier)")
                    }
            
            //Old array loop:
//            for i in 0 ..< self.countryOverlays.count {
//
//                let overlay = self.countryOverlays[i].polygons
//
//                print("Antalet lager för \(self.countryOverlays[i].isoA3) är \(overlay.count)")
//                print("Antalet länder-lager är \(self.countryOverlays.count)")
//                print("i är: \(i)")
//
//                if self.countryOverlays[i].isoA3 == countries[country].shortName {
//                    var identifier = ""
//                    if countries[country].visited == true {
//                        identifier = "visited"
//                        //self.mkOverlays.append(overlay)
//                    } else if countries[country].wantToGo {
//                        identifier = "wantToGo"
//                        //self.mkOverlays.append(overlay)
//                    }
//                    for j in 0..<overlay.count {
//                        //let visitedOverlay = countryOverlays[i].polygons
//                        overlay[j].identifier = identifier
//                        print("\(self.countryOverlays[i].isoA3):s lager är satt till: \(overlay[j].identifier)")
//                    }
//                }
//                print("Adding layer for country \(self.countryOverlays[i].isoA3)")
//            }
            
        }
    }
    
    func renderOverlayToMap() {
            //Old array loop:
//            for i in 0 ..< self.mkOverlays.count {
//                let overlay = self.mkOverlays[i]
//
//                self.mapView.addOverlays(overlay, level: .aboveRoads)
//        }
        
    }
    func renderOverlayToMapFromDict() {
            //New dictionary loop:
        for (_, value) in mkOverlaysDict {
            let overlay = value
            
            self.mapView.addOverlays(overlay, level: .aboveRoads)
            
            guard let overlays = overlayDict["SWE"]?.polygons else { break }
            for layer in overlays {
                //print("\(overlayDict["SWE"]?.isoA3) has the identifier: \(layer.identifier)")
                
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
        var alphaComponent: CGFloat = 0.8
        if let polygon = overlay as? CustomPolygon, polygon.identifier == "visited" {
            fillColor = .green
            alphaComponent = 0.8
        } else if let polygon = overlay as? CustomPolygon, polygon.identifier == "wantToGo" {
            fillColor = .yellow
            alphaComponent = 0.8
        } else {
            fillColor = .red
            alphaComponent = 0.3
        }
        renderer.fillColor = fillColor.withAlphaComponent(alphaComponent)
    }

    @IBAction func mapTaped(_ sender: UITapGestureRecognizer) {
        print("Tapped")
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
        
        //print("rendering layer")
        return renderer
        
    }
    
}


