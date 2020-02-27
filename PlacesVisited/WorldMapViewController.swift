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
    
    var overlayDict : Dictionary<String, CountryGeo>!
    var mkOverlaysDict : Dictionary<String, [MKOverlay]>!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let location = CLLocation(latitude: 55.663255, longitude:   13.597545)
        let regionRadius: CLLocationDistance = 5000000.0
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        mapView.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 2500000.0, maxCenterCoordinateDistance: 100000000.0), animated: true)
        
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
                    configureColorForOverlays(of: renderer, for: overlay)
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
    
    func renderOverlayToMap() {
        for (_, value) in mkOverlaysDict {
            let overlay = value
            
            self.mapView.addOverlays(overlay, level: .aboveRoads)
            print("Rendering overlay")
        }
    }
    
    func configureColorForOverlays(of renderer: MKPolygonRenderer, for overlay: MKOverlay) {
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
        configureColorForOverlays(of: renderer, for: overlay)
        renderer.lineWidth = 0.3
        
        return renderer
        
    }
    
}


