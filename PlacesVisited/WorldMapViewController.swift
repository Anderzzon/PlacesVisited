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
        updateOverlayColors()
    }
    
    //Update overlays if any changes have accured:
    func updateOverlayColors() {
        
        var countriesToLoop = self.countries.listOfCountriesToUpdate(for: .Europe)
        countriesToLoop += self.countries.listOfCountriesToUpdate(for: .Asia)
        countriesToLoop += self.countries.listOfCountriesToUpdate(for: .Africa)
        countriesToLoop += self.countries.listOfCountriesToUpdate(for: .NorthAmerica)
        countriesToLoop += self.countries.listOfCountriesToUpdate(for: .SouthAmerica)
        countriesToLoop += self.countries.listOfCountriesToUpdate(for: .Oceania)
        
        //Loop through countryOverlays and set the overlays identifyer to the correspeonding countrys status:
        for country in countriesToLoop {
            
            guard let overlays = overlayDict[country.shortName]?.polygons else { break }
            
            var identifier = ""
            if country.visited == true {
                identifier = "visited"
            } else if country.wantToGo == true {
                identifier = "wantToGo"
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
    
    //Add all ovrlays to the mapview:
    func renderOverlayToMap() {
        for (_, value) in mkOverlaysDict {
            let overlay = value
            
            self.mapView.addOverlays(overlay, level: .aboveRoads)
        }
    }
    
    //Set the color and alphaComponent for all layers:
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
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView , toCoordinateFrom: mapView)
            
            for (_, value) in overlayDict {
                let overlay = value.polygons
                mkOverlaysDict[value.isoA3!] = overlay
                
                for polygon in overlay as! [MKPolygon] {
                    let renderer = MKPolygonRenderer(polygon: polygon)
                    let mapPoint = MKMapPoint(tappedCoordinate)
                    let viewPoint = renderer.point(for: mapPoint)
                    if renderer.path.contains(viewPoint) {
                        
                        var countriesToLoop = self.countries.listOfCountries(for: .Europe)
                        countriesToLoop += self.countries.listOfCountries(for: .Asia)
                        countriesToLoop += self.countries.listOfCountries(for: .Africa)
                        countriesToLoop += self.countries.listOfCountries(for: .NorthAmerica)
                        countriesToLoop += self.countries.listOfCountries(for: .SouthAmerica)
                        countriesToLoop += self.countries.listOfCountries(for: .Oceania)
                        
                        for country in countriesToLoop {
                            if value.isoA3 == country.shortName {
                                let alert = UIAlertController(title: "Update status of \(country.fullName)", message: nil, preferredStyle: .actionSheet)
                                alert.view.tintColor = .orange
                                alert.view.largeContentTitle = title

                                var visitTitle = ""
                                var wantToGoTitle = ""
                                if country.visited == false {
                                    visitTitle = "Visited"
                                } else if country.visited == true {
                                    visitTitle = "Not visited"
                                }
                                if country.wantToGo == false {
                                    wantToGoTitle = "Want to go"
                                } else if country.wantToGo == true {
                                    wantToGoTitle = "Don't want to go"
                                }
                                if country.visited == true && country.wantToGo == true {
                                    visitTitle = "Not visited"
                                    wantToGoTitle = "Want to go"
                                }
                                
                                let visitButton = UIAlertAction(title: visitTitle, style: .default) {
                                    (action) in
                                    self.countries.updateVisit(country: country, index: nil)
                                    country.updateMap = true
                                    self.updateOverlayColors()
                                }
                                let wantToGoButton = UIAlertAction(title: wantToGoTitle, style: .default) {
                                    (action) in
                                    if country.visited == false {
                                        self.countries.updateWantToGo(country: country, index: nil)
                                          country.updateMap = true
                                          self.updateOverlayColors()
                                    } else if country.visited == true && country.wantToGo == true {
                                        self.countries.updateVisit(country: country, index: nil)
                                          country.updateMap = true
                                          self.updateOverlayColors()
                                    } else {
                                        self.countries.updateWantToGo(country: country, index: nil)
                                        self.countries.updateVisit(country: country, index: nil)
                                          country.updateMap = true
                                          self.updateOverlayColors()
                                    }
  
                                }
                                let cancel = UIAlertAction(title: "Cancel", style: .destructive)
                                
                                alert.addAction(visitButton)
                                alert.addAction(wantToGoButton)
                                alert.addAction(cancel)
                                self.present(alert, animated: true)
                                
                            }
                        }
                    }
                }
            }
        }
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
