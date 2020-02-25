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
    let countriesVisitedCircleLayer = CAShapeLayer()
    let bucketListCircleLayer = CAShapeLayer()
    let percentOfWorldCircleLayer = CAShapeLayer()
    let smallTrackLayer = CAShapeLayer()
    
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var percentOfBucketListProgress: UILabel!
    @IBOutlet weak var bucketListCount: UILabel!

    @IBOutlet weak var countriesVisited: UIView!
    @IBOutlet weak var onYourBucketList: UIView!
    @IBOutlet weak var percentOfTheWorld: UIView!
    
    @IBOutlet weak var numberOfCountriesVisitedLabel: UILabel!
    @IBOutlet weak var numberOfCountriesOnBucketList: UILabel!
    @IBOutlet weak var percentOfWorldVisited: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //statusBar()
        //adjustNavigationBar()
        
        countries.loadItems()
        print(countries.percentOfWorldVisited()) //Bugtest
        createBigCircle()
    
        createSmallCircle(progressLayer: countriesVisitedCircleLayer, outletView: countriesVisited)
        createSmallCircle(progressLayer: bucketListCircleLayer, outletView: onYourBucketList)
        createSmallCircle(progressLayer: percentOfWorldCircleLayer, outletView: percentOfTheWorld)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        countries.loadItems()
        percentOfBucketListProgress.text = "\(countries.bucketListProgress())%"
        bucketListCount.text = "\(countries.numberOfCountriesWantToGoTo) more to go"
        
        animateCircle()
        animatePercentOfWorldCircle()
        
        numberOfCountriesVisitedLabel.text = "\(countries.numberOfCountriesVisited)"
        numberOfCountriesOnBucketList.text = "\(countries.numberOfCountriesWantToGoTo)"
        percentOfWorldVisited.text = "\(countries.percentOfWorldVisited())%"
        
    }
    
    //Large circle at the top:
    func createBigCircle() {
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
    
    //Animation for the big circle:
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
    
    func animatePercentOfWorldCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let percent = CGFloat(countries.percentOfWorldVisited()/100)
        
        percentOfWorldCircleLayer.strokeEnd = 0
        basicAnimation.toValue = percent
        basicAnimation.duration = 0.8
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        percentOfWorldCircleLayer.add(basicAnimation, forKey: "basic")
    }
    
    //small circles
    func createSmallCircle(progressLayer: CAShapeLayer, outletView:UIView) {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        smallTrackLayer.path = circularPath.cgPath
        
        smallTrackLayer.fillColor = .none
        smallTrackLayer.strokeColor = UIColor.lightGray.cgColor
        smallTrackLayer.lineWidth = 3
        smallTrackLayer.lineCap = CAShapeLayerLineCap.round
        smallTrackLayer.position.x = outletView.center.x
        smallTrackLayer.position.y = outletView.center.y-44
        
        view.layer.addSublayer(smallTrackLayer)
        
        progressLayer.path = circularPath.cgPath
        
        progressLayer.fillColor = .none
        progressLayer.strokeColor = UIColor.orange.cgColor
        progressLayer.lineWidth = 3
        progressLayer.position.x = outletView.center.x
        progressLayer.position.y = outletView.center.y-44
        
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        progressLayer.strokeEnd = 1

        view.layer.addSublayer(progressLayer)
    }
    
    func adjustNavigationBar() {
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            let color = UIColor(red: 249/256, green: 248/256, blue: 248/256, alpha: 1)
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.lightText
        }
    }
    
    func statusBar() {
        if #available(iOS 13.0, *) {
            
            let color = UIColor(red: 249/256, green: 248/256, blue: 248/256, alpha: 1)
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = color
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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
