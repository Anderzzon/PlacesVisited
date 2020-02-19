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
        updateOverlayColors()
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
        
        //Öland, test:
//        var olandPoints: [CLLocationCoordinate2D] = []
//        olandPoints.append(CLLocationCoordinate2DMake(56.203388, 16.406799))
//        olandPoints.append(CLLocationCoordinate2DMake(56.234254, 16.476919))
//        olandPoints.append(CLLocationCoordinate2DMake(56.557653, 16.640534))
//        olandPoints.append(CLLocationCoordinate2DMake(56.586625, 16.696046))
//        olandPoints.append(CLLocationCoordinate2DMake(56.801604, 16.786619))
//        olandPoints.append(CLLocationCoordinate2DMake(56.836782, 16.865504))
//        olandPoints.append(CLLocationCoordinate2DMake(57.180413, 17.070023))
//        olandPoints.append(CLLocationCoordinate2DMake(57.284779, 17.061258))
//        olandPoints.append(CLLocationCoordinate2DMake(57.311613, 17.140143))
//        olandPoints.append(CLLocationCoordinate2DMake(57.366799, 17.070023))
//        olandPoints.append(CLLocationCoordinate2DMake(57.286358, 16.956077))
//        olandPoints.append(CLLocationCoordinate2DMake(57.226307, 16.964842))
//        olandPoints.append(CLLocationCoordinate2DMake(56.932553, 16.734028))
//        olandPoints.append(CLLocationCoordinate2DMake(56.881591, 16.715309))
//        olandPoints.append(CLLocationCoordinate2DMake(56.884483, 16.649605))
//        olandPoints.append(CLLocationCoordinate2DMake(56.526536, 16.382762))
//        olandPoints.append(CLLocationCoordinate2DMake(56.424689, 16.390445))
//        olandPoints.append(CLLocationCoordinate2DMake(56.420206, 16.405497))
//        olandPoints.append(CLLocationCoordinate2DMake(56.270756, 16.396896))
//        let olandPolygon = MKPolygon(coordinates: &olandPoints, count: olandPoints.count)
        
        //Read json:
        if let json = readJSONFromFile(fileName: "countries") as? [[String : Any]] {
            
            for co in json {
                
                let country = CountryGeo(json: co )
                
                countryOverlays.append(country)
                print(country)
                print(countryOverlays.count)
                
                //print(c.name)
                //print(c.points)
                
                //            let countryPoints = MKPolygon(coordinates: &country.points, count: country.points.count)
                //
                //            var overlays:[MKPolygon] = []
                //            overlays.append(countryPoints)
                
                //let overlays = countryOverlays[0].polygons
                //mapView.addOverlays(overlays, level: .aboveRoads)
                
            }
            
            for i in 0 ..< countryOverlays.count {
                
                let overlay = countryOverlays[i].polygons
                
                print("Antalet lager för \(countryOverlays[i].isoA3) är \(overlay.count)")
                print("Antalet länder-lager är \(countryOverlays.count)")
                print("i är: \(i)")
                //overlay1 = countryOverlays[1].polygons[0]
                //let overlay2 = countryOverlays[1].polygons[1]
                //let overlay3 = countryOverlays[1].polygons[2]
                //mapView.addOverlay(overlay1)
                //mapView.addOverlay(overlay2)
                //mapView.addOverlay(overlay3)
                if countryOverlays[i].isoA3 == "ABW" {
                    for j in 0..<overlay.count {
                        //let visitedOverlay = countryOverlays[i].polygons
                        overlay[j].identifier = "visited"
                    }
                    mkOverlays.append(overlay)
                    
                    mapView.addOverlays(overlay, level: .aboveRoads)
                } else {
                    mkOverlays.append(overlay)
                    
                    mapView.addOverlays(overlay, level: .aboveRoads)
                }
                
//                if countryOverlays[i].isoA3 == "CYM" {
//                    variables.fillColor = CONSTANT.redColor
//                } else {
//                    variables.fillColor = CONSTANT.blueColor
//                }

                
                print("Adding layer for country \(countryOverlays[i].isoA3)")
            }
            
        }
        
        //        var arubaPoints:[CLLocationCoordinate2D] = []
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.577582098000036, -69.996937628999916))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.531724351000051, -69.936390753999945))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.519232489000046, -69.924672003999945))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.497015692000076, -69.915760870999918))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.453558661000045, -69.880197719999842))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.427394924000097, -69.876820441999939))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.417669989000046, -69.888091600999928))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.417792059000107, -69.908802863999938))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.425970770000035, -69.930531378999888))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.440375067000090, -69.945139126999919))
        //
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.440375067000090, -69.924672003999945))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.447211005000014, -69.924672003999945))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.463202216000099, -69.958566860999923))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.522935289000088, -70.027658657999922))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.531154690000079, -70.048085089999887))
        //
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.537176825000088, -70.058094855999883))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.546820380000057, -70.062408006999874))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.556952216000113, -70.060373501999948))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.574042059000064, -70.051096157999893))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.583726304000024, -70.048736131999931))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.600002346000053, -70.052642381999931))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.614243882000054, -70.059641079999921))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.625392971000068, -70.061105923999975))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.632147528000104, -70.048736131999931))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.585516669000100, -70.007150844999870))
        //        arubaPoints.append(CLLocationCoordinate2DMake(12.577582098000036, -69.996937628999916))
        //
        //
        //
        //        let polyline = MKPolyline(coordinates: &arubaPoints, count: arubaPoints.count)
        //        let arubaLine
        //        mapView?.addOverlay(polyline)
        
        //        let arubaPolygon = MKPolygon(coordinates: &arubaPoints, count: arubaPoints.count)
        //        mapView.addOverlay(arubaPolygon)
        
//        var points: [CLLocationCoordinate2D] = []
//
//        var interiorPoints: [CLLocationCoordinate2D] = []
//
//        interiorPoints.append(CLLocationCoordinate2DMake(55.663255, 13.597545))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.671883, 13.618270))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.689883, 13.622607))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.690902, 13.606102))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.696402, 13.593452))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.695994, 13.585621))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.704514, 13.559899))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.699631, 13.554247))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.683915, 13.553619))
//        interiorPoints.append(CLLocationCoordinate2DMake(55.676655, 13.559500))
//
//        points.append(CLLocationCoordinate2DMake(55.406937, 12.888584))
//        points.append(CLLocationCoordinate2DMake(55.360394, 13.367504))
//        points.append(CLLocationCoordinate2DMake(55.434628, 13.983833))
//        points.append(CLLocationCoordinate2DMake(55.386345, 14.062330))
//        points.append(CLLocationCoordinate2DMake(55.383413, 14.190816))
//        points.append(CLLocationCoordinate2DMake(55.541495, 14.342881))
//        points.append(CLLocationCoordinate2DMake(55.671719, 14.269976))
//        points.append(CLLocationCoordinate2DMake(55.698463, 14.208920))
//        points.append(CLLocationCoordinate2DMake(55.792828, 14.204517))
//        points.append(CLLocationCoordinate2DMake(55.894471, 14.267451))
//        points.append(CLLocationCoordinate2DMake(55.921003, 14.328321))
//        points.append(CLLocationCoordinate2DMake(55.938167, 14.319612))
//        points.append(CLLocationCoordinate2DMake(55.963512, 14.352621))
//        points.append(CLLocationCoordinate2DMake(55.960953, 14.377070))
//        points.append(CLLocationCoordinate2DMake(55.962836, 14.376786))
//        points.append(CLLocationCoordinate2DMake(55.974236, 14.384246))
//        points.append(CLLocationCoordinate2DMake(55.972113, 14.411236))
//        points.append(CLLocationCoordinate2DMake(55.976274, 14.407790))
//        points.append(CLLocationCoordinate2DMake(55.982625, 14.408981))
//
//        points.append(CLLocationCoordinate2DMake(55.730361, 12.989835))
//        points.append(CLLocationCoordinate2DMake(55.700098, 13.048615))
//        points.append(CLLocationCoordinate2DMake(55.666379, 13.063482))
//        points.append(CLLocationCoordinate2DMake(55.640134, 13.044253))
//        points.append(CLLocationCoordinate2DMake(55.594018, 12.925559))
//        points.append(CLLocationCoordinate2DMake(55.559618, 12.898512))
//
//
//        let skanePolygon = MKPolygon(coordinates: &points, count: points.count)
//
//        let interiorPolygon = MKPolygon(coordinates: &interiorPoints, count: interiorPoints.count)
//
//        let finalPolygon = MKPolygon(coordinates: &points, count: points.count, interiorPolygons: [interiorPolygon])
//
//        let combined:[MKPolygon] = [olandPolygon, skanePolygon]
        
        //let multPolygon = MKMultiPolygon(combined)
        //mapView.addOverlay(finalPolygon)
        //mapView.addOverlay(olandPolygon)
        //mapView.addOverlay(finalPolygon, level: .aboveRoads)
        
        //mapView.addOverlays(combined, level: .aboveRoads)
        
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


