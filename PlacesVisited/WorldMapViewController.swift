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
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let location = CLLocation(latitude: 55.663255, longitude:   13.597545)
        let regionRadius: CLLocationDistance = 5000000.0
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)

        produceOverlay()
        
        // Do any additional setup after loading the view.
    }
    
    private func showVisitedCountries() {
        //If statment to determin if a country should show on the map
        produceOverlay()
    }
    
    private func produceOverlay() {
        
        var points: [CLLocationCoordinate2D] = []
        var olandPoints: [CLLocationCoordinate2D] = []
        
        var interiorPoints: [CLLocationCoordinate2D] = []
        
        interiorPoints.append(CLLocationCoordinate2DMake(55.663255, 13.597545))
        interiorPoints.append(CLLocationCoordinate2DMake(55.671883, 13.618270))
        interiorPoints.append(CLLocationCoordinate2DMake(55.689883, 13.622607))
        interiorPoints.append(CLLocationCoordinate2DMake(55.690902, 13.606102))
        interiorPoints.append(CLLocationCoordinate2DMake(55.696402, 13.593452))
        interiorPoints.append(CLLocationCoordinate2DMake(55.695994, 13.585621))
        interiorPoints.append(CLLocationCoordinate2DMake(55.704514, 13.559899))
        interiorPoints.append(CLLocationCoordinate2DMake(55.699631, 13.554247))
        interiorPoints.append(CLLocationCoordinate2DMake(55.683915, 13.553619))
        interiorPoints.append(CLLocationCoordinate2DMake(55.676655, 13.559500))
        
        
        points.append(CLLocationCoordinate2DMake(55.406937, 12.888584))
        points.append(CLLocationCoordinate2DMake(55.360394, 13.367504))
        points.append(CLLocationCoordinate2DMake(55.434628, 13.983833))
        points.append(CLLocationCoordinate2DMake(55.386345, 14.062330))
        points.append(CLLocationCoordinate2DMake(55.383413, 14.190816))
        points.append(CLLocationCoordinate2DMake(55.541495, 14.342881))
        points.append(CLLocationCoordinate2DMake(55.671719, 14.269976))
        points.append(CLLocationCoordinate2DMake(55.698463, 14.208920))
        points.append(CLLocationCoordinate2DMake(55.792828, 14.204517))
        points.append(CLLocationCoordinate2DMake(55.894471, 14.267451))
        points.append(CLLocationCoordinate2DMake(55.921003, 14.328321))
        points.append(CLLocationCoordinate2DMake(55.938167, 14.319612))
        points.append(CLLocationCoordinate2DMake(55.963512, 14.352621))
        points.append(CLLocationCoordinate2DMake(55.960953, 14.377070))
        points.append(CLLocationCoordinate2DMake(55.962836, 14.376786))
        points.append(CLLocationCoordinate2DMake(55.974236, 14.384246))
        points.append(CLLocationCoordinate2DMake(55.972113, 14.411236))
        points.append(CLLocationCoordinate2DMake(55.976274, 14.407790))
        points.append(CLLocationCoordinate2DMake(55.982625, 14.408981))
        
        points.append(CLLocationCoordinate2DMake(55.730361, 12.989835))
        points.append(CLLocationCoordinate2DMake(55.700098, 13.048615))
        points.append(CLLocationCoordinate2DMake(55.666379, 13.063482))
        points.append(CLLocationCoordinate2DMake(55.640134, 13.044253))
        points.append(CLLocationCoordinate2DMake(55.594018, 12.925559))
        points.append(CLLocationCoordinate2DMake(55.559618, 12.898512))
        
        //Öland:
        olandPoints.append(CLLocationCoordinate2DMake(56.203388, 16.406799))
        olandPoints.append(CLLocationCoordinate2DMake(56.234254, 16.476919))
        olandPoints.append(CLLocationCoordinate2DMake(56.557653, 16.640534))
        olandPoints.append(CLLocationCoordinate2DMake(56.586625, 16.696046))
        olandPoints.append(CLLocationCoordinate2DMake(56.801604, 16.786619))
        olandPoints.append(CLLocationCoordinate2DMake(56.836782, 16.865504))
        olandPoints.append(CLLocationCoordinate2DMake(57.180413, 17.070023))
        olandPoints.append(CLLocationCoordinate2DMake(57.284779, 17.061258))
        olandPoints.append(CLLocationCoordinate2DMake(57.311613, 17.140143))
        olandPoints.append(CLLocationCoordinate2DMake(57.366799, 17.070023))
        olandPoints.append(CLLocationCoordinate2DMake(57.286358, 16.956077))
        olandPoints.append(CLLocationCoordinate2DMake(57.226307, 16.964842))
        olandPoints.append(CLLocationCoordinate2DMake(56.932553, 16.734028))
        olandPoints.append(CLLocationCoordinate2DMake(56.881591, 16.715309))
        olandPoints.append(CLLocationCoordinate2DMake(56.884483, 16.649605))
        olandPoints.append(CLLocationCoordinate2DMake(56.526536, 16.382762))
        olandPoints.append(CLLocationCoordinate2DMake(56.424689, 16.390445))
        olandPoints.append(CLLocationCoordinate2DMake(56.420206, 16.405497))
        olandPoints.append(CLLocationCoordinate2DMake(56.270756, 16.396896))
        let olandPolygon = MKPolygon(coordinates: &olandPoints, count: olandPoints.count)
        
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        let interiorPolygon = MKPolygon(coordinates: &interiorPoints, count: interiorPoints.count)
        
        let finalPolygon = MKPolygon(coordinates: &points, count: points.count, interiorPolygons: [interiorPolygon])
        mapView.addOverlay(finalPolygon)
        mapView.addOverlay(olandPolygon)
        

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
        
            let polyRenderer = MKPolygonRenderer(overlay: overlay)
            polyRenderer.strokeColor = UIColor.black
            polyRenderer.fillColor = UIColor.green
            polyRenderer.lineWidth = 0.3
            
            return polyRenderer

    }
    
    
}
