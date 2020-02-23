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
//    var countryOverlays: [CountryGeo] = []
//    var mkOverlays: [[MKOverlay]] = []
    
    var overlayDict : Dictionary<String, CountryGeo>!
    var mkOverlaysDict : Dictionary<String, [MKOverlay]>!
    //var overlayDict = [String: CountryGeo]()
    //var mkOverlaysDict = [String: [MKOverlay]]()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
                let location = CLLocation(latitude: 55.663255, longitude:   13.597545)
                let regionRadius: CLLocationDistance = 5000000.0
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                mapView.setRegion(region, animated: true)
        mapView.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 2500000.0, maxCenterCoordinateDistance: 100000000.0), animated: true)
        
        //readJson()
        //produceOverlay()
        //createAllOverlays()
        renderOverlayToMap()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateAllOverlayColors()
    }
    
    //Update overlays if any change has accured:
    func updateOverlayColors(for continent: ListOfCountries.Continents) {
        
        let countriesToLoop = self.countries.listOfCountriesToUpdate(for: continent)
        
        //Loop through countryOverlays and set the overlays identifyer to the correspeonding countrys status:
        for country in countriesToLoop {
            
            guard let overlays = overlayDict[country.shortName]?.polygons else { break }
            
            var identifier = ""
            if country.visited == true {
                identifier = "visited"
                print("Visited: \(country.fullName)")
            } else if country.wantToGo == true {
                identifier = "wantToGo"
                print("Want to go to: \(country.fullName)")
            }
            
            //Loop through every individual overlay of the country:
            for overlay in overlays {
                overlay.identifier = identifier
            }
            
            for overlay in mapView.overlays {
                if let renderer = mapView.renderer(for: overlay) as? MKPolygonRenderer {
                    configureColor(of: renderer, for: overlay)
                }
            }
            country.updateMap = false
        }
    }
    
    private func updateAllOverlayColors() {
            self.updateOverlayColors(for: .Europe)
            self.updateOverlayColors(for: .Africa)
            self.updateOverlayColors(for: .Asia)
            self.updateOverlayColors(for: .NorthAmerica)
            self.updateOverlayColors(for: .SouthAmerica)
            self.updateOverlayColors(for: .Oceania)
    }
    
    private func readJson() {
        //Read json:
        if let json = readJSONFromFile(fileName: "allCountries") as? [[String : Any]] {

            //Loop through json and append countries to array of countryOverlays:
            for co in json {
                
                let country = CountryGeo(json: co )
            
                //countryOverlays.append(country)
                overlayDict[country.isoA3!] = country
            }
        }
    }
    
    //Generate all overlays and add the to the dicionary of MKOverlays
    private func produceOverlay() {
        for (_, value) in overlayDict {
            let overlay = value.polygons
            mkOverlaysDict[value.isoA3!] = overlay
        }
    }
    
    private func createAllOverlays() {
                let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
                dispatchQueue.async{
                    //Time consuming task here:
                    self.createOverlays(for: .Europe)
                    self.createOverlays(for: .Asia)
                    self.createOverlays(for: .SouthAmerica)
                    self.createOverlays(for: .NorthAmerica)
                    self.createOverlays(for: .Oceania)
                    self.createOverlays(for: .Africa)
        }
    }
    
    private func createOverlays(for continent: ListOfCountries.Continents) {
        
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
        }
    }
    
    func renderOverlayToMap() {
            //New dictionary loop:
        for (_, value) in mkOverlaysDict {
            let overlay = value
            
            self.mapView.addOverlays(overlay, level: .aboveRoads)
            print("Rendering overlay")
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
        //let visitedColor = UIColor(red: 61/256, green: 255/256, blue: 123/256, alpha: 1.0)
        let visitedColor = UIColor(named: "VisitedColor")
        let fillColor: UIColor
        var alphaComponent: CGFloat = 0.8
        if let polygon = overlay as? CustomPolygon, polygon.identifier == "visited" {
            fillColor = visitedColor!
            alphaComponent = 1.0
        } else if let polygon = overlay as? CustomPolygon, polygon.identifier == "wantToGo" {
            fillColor = .orange
            alphaComponent = 1.0
        } else {
            fillColor = .red
            alphaComponent = 0.0
        }
        renderer.fillColor = fillColor.withAlphaComponent(alphaComponent)
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


