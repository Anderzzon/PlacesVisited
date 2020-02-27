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
    
    let bigCircleView = UIView()
    let countriesVisitedView = UIView()
    let onYourBucketListView = UIView()
    let percentOfTheWorldView = UIView()
    
    let percentBigLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let myBucketListLabel: UILabel = {
        let label = UILabel()
        label.text = "My bucketlist"
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let leftToGoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nrOfCountriesVisitedLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nrOfCountriesOnBucketListLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let percentOfWorldVisitedLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let countriesVisitedTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Countries visited"
        label.numberOfLines = 0
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let bucketListTextLabel: UILabel = {
        let label = UILabel()
        label.text = "On your bucket list"
        label.numberOfLines = 0
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let percentOfWorldTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Of the world"
        label.numberOfLines = 0
        label.textColor = .orange
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let devider: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //statusBar()
        //adjustNavigationBar()
        
        //Load Country objects:
        countries.loadItems()
        
        print(countries.percentOfWorldVisited()) //Bugtest
        
        //Add views:
        view.addSubview(bigCircleView)
        bigCircleView.addSubview(percentBigLabel)
        bigCircleView.addSubview(myBucketListLabel)
        bigCircleView.addSubview(leftToGoLabel)
        
        view.addSubview(devider)
        
        view.addSubview(countriesVisitedView)
        view.addSubview(onYourBucketListView)
        view.addSubview(percentOfTheWorldView)
        
        countriesVisitedView.addSubview(nrOfCountriesVisitedLabel)
        onYourBucketListView.addSubview(nrOfCountriesOnBucketListLabel)
        percentOfTheWorldView.addSubview(percentOfWorldVisitedLabel)
        
        view.addSubview(countriesVisitedTextLabel)
        view.addSubview(bucketListTextLabel)
        view.addSubview(percentOfWorldTextLabel)

        bigCircleView.translatesAutoresizingMaskIntoConstraints = false
        countriesVisitedView.translatesAutoresizingMaskIntoConstraints = false
        onYourBucketListView.translatesAutoresizingMaskIntoConstraints = false
        percentOfTheWorldView.translatesAutoresizingMaskIntoConstraints = false
        
        createBigCircle()
        
        createSmallCircle(progressLayer: countriesVisitedCircleLayer, outletView: countriesVisitedView)
        createSmallCircle(progressLayer: bucketListCircleLayer, outletView: onYourBucketListView)
        createSmallCircle(progressLayer: percentOfWorldCircleLayer, outletView: percentOfTheWorldView)
        
        setupLayout()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        countries.loadItems()
        if countries.bucketListProgress() > 0 {
            percentBigLabel.text = "\(countries.bucketListProgress())%"
        }
        leftToGoLabel.text = "\(countries.numberOfCountriesWantToGoTo) more to go"
        
        animateCircle()
        animatePercentOfWorldCircle()
        
        nrOfCountriesVisitedLabel.text = "\(countries.numberOfCountriesVisited)"
        nrOfCountriesOnBucketListLabel.text = "\(countries.numberOfCountriesWantToGoTo)"
        percentOfWorldVisitedLabel.text = "\(countries.percentOfWorldVisited())%"
        
    }
    
    //Large circle at the top:
    func createBigCircle() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 120, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        //Circle track layer:
        trackLayer.path = circularPath.cgPath
        
        trackLayer.fillColor = .none
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = CAShapeLayerLineCap.round
        
        trackLayer.position.x = bigCircleView.center.x + 125
        trackLayer.position.y = bigCircleView.center.y + 125
        
        bigCircleView.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.fillColor = .none
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.position.x = bigCircleView.center.x + 125
        shapeLayer.position.y = bigCircleView.center.y + 125
    
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        shapeLayer.strokeEnd = 0
        bigCircleView.layer.addSublayer(shapeLayer)
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
        smallTrackLayer.position.x = outletView.center.x + 45
        smallTrackLayer.position.y = outletView.center.y + 45
        
        outletView.layer.addSublayer(smallTrackLayer)
        
        progressLayer.path = circularPath.cgPath
        
        progressLayer.fillColor = .none
        progressLayer.strokeColor = UIColor.orange.cgColor
        progressLayer.lineWidth = 3
        progressLayer.position.x = outletView.center.x + 45
        progressLayer.position.y = outletView.center.y + 45
        
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        progressLayer.strokeEnd = 1

        outletView.layer.addSublayer(progressLayer)
    }
    
    private func setupLayout() {
        let screenSize = UIScreen.main.nativeBounds.size.height
        
        if screenSize <= 1136{ //For iPhone SE
            countriesVisitedTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            bucketListTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            percentOfWorldTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            bigCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            bigCircleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 22).isActive = true
            bigCircleView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            bigCircleView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            
            devider.topAnchor.constraint(equalTo: bigCircleView.bottomAnchor, constant: 22).isActive = true
            devider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22).isActive = true
            devider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22).isActive = true
            devider.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            countriesVisitedView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22).isActive = true
            countriesVisitedView.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 15).isActive = true
            countriesVisitedView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            countriesVisitedView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            percentOfTheWorldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22).isActive = true
            percentOfTheWorldView.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 15).isActive = true
            percentOfTheWorldView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            percentOfTheWorldView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            onYourBucketListView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            onYourBucketListView.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 15).isActive = true
            onYourBucketListView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            onYourBucketListView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            countriesVisitedTextLabel.centerXAnchor.constraint(equalTo: countriesVisitedView.centerXAnchor).isActive = true
            countriesVisitedTextLabel.topAnchor.constraint(equalTo: countriesVisitedView.bottomAnchor, constant: 3).isActive = true
            countriesVisitedTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            countriesVisitedTextLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            bucketListTextLabel.centerXAnchor.constraint(equalTo: onYourBucketListView.centerXAnchor).isActive = true
            bucketListTextLabel.topAnchor.constraint(equalTo: onYourBucketListView.bottomAnchor, constant: 3).isActive = true
            bucketListTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            bucketListTextLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            percentOfWorldTextLabel.centerXAnchor.constraint(equalTo: percentOfTheWorldView.centerXAnchor).isActive = true
            percentOfWorldTextLabel.topAnchor.constraint(equalTo: percentOfTheWorldView.bottomAnchor, constant: 3).isActive = true
            percentOfWorldTextLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
            percentOfWorldTextLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
        } else { //other screens
            bigCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            bigCircleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
            bigCircleView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            bigCircleView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            
            devider.topAnchor.constraint(equalTo: bigCircleView.bottomAnchor, constant: 44).isActive = true
            devider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44).isActive = true
            devider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -44).isActive = true
            devider.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            countriesVisitedView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44).isActive = true
            countriesVisitedView.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 44).isActive = true
            countriesVisitedView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            countriesVisitedView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            percentOfTheWorldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -44).isActive = true
            percentOfTheWorldView.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 44).isActive = true
            percentOfTheWorldView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            percentOfTheWorldView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            onYourBucketListView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            onYourBucketListView.topAnchor.constraint(equalTo: devider.bottomAnchor, constant: 44).isActive = true
            onYourBucketListView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            onYourBucketListView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            countriesVisitedTextLabel.centerXAnchor.constraint(equalTo: countriesVisitedView.centerXAnchor).isActive = true
            countriesVisitedTextLabel.topAnchor.constraint(equalTo: countriesVisitedView.bottomAnchor, constant: 10).isActive = true
            countriesVisitedTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            countriesVisitedTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            bucketListTextLabel.centerXAnchor.constraint(equalTo: onYourBucketListView.centerXAnchor).isActive = true
            bucketListTextLabel.topAnchor.constraint(equalTo: onYourBucketListView.bottomAnchor, constant: 10).isActive = true
            bucketListTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            bucketListTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            percentOfWorldTextLabel.centerXAnchor.constraint(equalTo: percentOfTheWorldView.centerXAnchor).isActive = true
            percentOfWorldTextLabel.topAnchor.constraint(equalTo: percentOfTheWorldView.bottomAnchor, constant: 10).isActive = true
            percentOfWorldTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            percentOfWorldTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        //constraints for all devices:
        percentBigLabel.centerXAnchor.constraint(equalTo: bigCircleView.centerXAnchor).isActive = true
        percentBigLabel.centerYAnchor.constraint(equalTo: bigCircleView.centerYAnchor).isActive = true
        percentBigLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        percentBigLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        myBucketListLabel.centerXAnchor.constraint(equalTo: bigCircleView.centerXAnchor).isActive = true
        myBucketListLabel.bottomAnchor.constraint(equalTo: percentBigLabel.topAnchor, constant: -14).isActive = true
        myBucketListLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        myBucketListLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        leftToGoLabel.centerXAnchor.constraint(equalTo: bigCircleView.centerXAnchor).isActive = true
        leftToGoLabel.topAnchor.constraint(equalTo: percentBigLabel.bottomAnchor, constant: 14).isActive = true
        leftToGoLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        leftToGoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nrOfCountriesVisitedLabel.centerXAnchor.constraint(equalTo: countriesVisitedView.centerXAnchor).isActive = true
        nrOfCountriesVisitedLabel.centerYAnchor.constraint(equalTo: countriesVisitedView.centerYAnchor).isActive = true
        nrOfCountriesVisitedLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nrOfCountriesVisitedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nrOfCountriesOnBucketListLabel.centerXAnchor.constraint(equalTo: onYourBucketListView.centerXAnchor).isActive = true
        nrOfCountriesOnBucketListLabel.centerYAnchor.constraint(equalTo: onYourBucketListView.centerYAnchor).isActive = true
        nrOfCountriesOnBucketListLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nrOfCountriesOnBucketListLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        percentOfWorldVisitedLabel.centerXAnchor.constraint(equalTo: percentOfTheWorldView.centerXAnchor).isActive = true
        percentOfWorldVisitedLabel.centerYAnchor.constraint(equalTo: percentOfTheWorldView.centerYAnchor).isActive = true
        percentOfWorldVisitedLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        percentOfWorldVisitedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
