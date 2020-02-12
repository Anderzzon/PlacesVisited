//
//  MapViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-02-05.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController, MGLMapViewDelegate {
    
//    var mapView: MGLMapView!
//    let url = URL(string: "mapbox://styles/westervind/ck69b1m1r0pbp1ipepz3yfxt4")
//    let layerIdentifier = "wantToGo"
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//        mapView = MGLMapView(frame: view.bounds, styleURL: url)
//
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 3, animated: false)
//        view.addSubview(mapView)
//
//        mapView.delegate = self
//
//        }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var mapView: MGLMapView!
    var contoursLayer: MGLStyleLayer?
    let url = URL(string: "mapbox://styles/westervind/ck69b1m1r0pbp1ipepz3yfxt4")
    let layerIdentifier = "ne_10m_admin_0_sovereignty-b1inen"
     
    override func viewDidLoad() {
    super.viewDidLoad()
     
    mapView = MGLMapView(frame: view.bounds, styleURL: url)
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     
    mapView.setCenter(CLLocationCoordinate2D(latitude: 37.745395, longitude: -119.594421), zoomLevel: 11, animated: false)
    view.addSubview(mapView)
     
    addToggleButton()
     
    mapView.delegate = self
    }
     
    
    // Wait until the style is loaded before modifying the map style
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
    addLayer(to: style)
    }
     
    func changeOpacity(name: String) {
        guard let layer = mapView.style?.layer(withIdentifier: layerIdentifier) as? MGLFillStyleLayer else {
            fatalError("Could not cast to specified MGLFillStyleLayer")
        }
        // Check if a state was selected, then change the opacity of the states that were not selected.
        if !name.isEmpty {
            layer.fillOpacity = NSExpression(format: "TERNARY(NAME = %@, 1, 0)", name)
        } else {
            // Reset the opacity for all states if the user did not tap on a state.
            layer.fillOpacity = NSExpression(forConstantValue: 1)
        }
    }
    
    func addLayer(to style: MGLStyle) {
    let source = MGLVectorTileSource(identifier: "contours", configurationURL: NSURL(string: "mapbox://mapbox.mapbox-terrain-v2")! as URL)
     
    let layer = MGLLineStyleLayer(identifier: "contours", source: source)
    layer.sourceLayerIdentifier = "contour"
    layer.lineJoin = NSExpression(forConstantValue: "round")
    layer.lineCap = NSExpression(forConstantValue: "round")
    layer.lineColor = NSExpression(forConstantValue: UIColor.brown)
    layer.lineWidth = NSExpression(forConstantValue: 1.0)
     
    style.addSource(source)
    if let water = style.layer(withIdentifier: "water") {
    // You can insert a layer below an existing style layer
    style.insertLayer(layer, below: water)
    } else {
    // or you can simply add it above all layers
    style.addLayer(layer)
    }
     
    self.contoursLayer = layer
     
    showContours()
    }
     
    @objc func toggleLayer(sender: UIButton) {
    sender.isSelected = !sender.isSelected
    if sender.isSelected {
    showContours()
    } else {
    hideContours()
    }
    }
     
    func showContours() {
    self.contoursLayer?.isVisible = true
    }
     
    func hideContours() {
    self.contoursLayer?.isVisible = false
    }
     
    func addToggleButton() {
    let button = UIButton(type: .system)
    button.setTitle("Toggle Contours", for: .normal)
    button.isSelected = true
    button.sizeToFit()
    button.center.x = self.view.center.x
    button.frame = CGRect(origin: CGPoint(x: button.frame.origin.x, y: self.view.frame.size.height - button.frame.size.height - 5), size: button.frame.size)
    button.addTarget(self, action: #selector(toggleLayer(sender:)), for: .touchUpInside)
    self.view.addSubview(button)
     
    if #available(iOS 11.0, *) {
    let safeArea = view.safeAreaLayoutGuide
    button.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
    button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -5),
    button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
    ]
     
    NSLayoutConstraint.activate(constraints)
    } else {
    button.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    }

}
