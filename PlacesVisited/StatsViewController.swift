//
//  StatsViewController.swift
//  PlacesVisited
//
//  Created by Erik Andersson on 2020-01-30.
//  Copyright © 2020 Erik. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var countries : ListOfCountries!
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var percentOfBucketListProgress: UILabel!
    
    @IBOutlet weak var bucketListCount: UILabel!
    
    
    private func continentsForSectionIndex(_ index: Int) -> ListOfCountries.Continents? {
        return ListOfCountries.Continents(rawValue: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        countries.loadItems()
        print(countries.percentOfWorldVisited())
        createCircle()
    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        countries.loadItems()
        percentOfBucketListProgress.text = "\(countries.bucketListProgress())%"
        bucketListCount.text = "\(countries.numberOfCountriesWantToGoTo) more to go"
        
        animateCircle()
        
    }
    
    
    
    func createCircle() {
        //view.layer.addSublayer(shapeLayer)
        //let center = view.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 120, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        //Circle track layer:
        trackLayer.path = circularPath.cgPath
        
        trackLayer.fillColor = .none
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position.x = statsView.center.x
        trackLayer.position.y = statsView.center.y-44
        
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.fillColor = .none
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position.x = statsView.center.x
        shapeLayer.position.y = statsView.center.y-44
    
        
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        shapeLayer.strokeEnd = 1
        view.layer.addSublayer(shapeLayer)
    }
    
    func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let percent = CGFloat(countries.bucketListProgress()/100)
        print(percent)
        shapeLayer.strokeEnd = 0
        basicAnimation.toValue = percent
        basicAnimation.duration = 0.8
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basic")
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
