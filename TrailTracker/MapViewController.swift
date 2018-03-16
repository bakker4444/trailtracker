//
//  ViewController.swift
//  TrailTracker
//
//  Created by Vince Reyes on 3/8/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import MapKit



class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var weight: String?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var avgSpeedLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    var startLocation: CLLocation!
    var lastLocation: CLLocation!

    var startDate: Date!
    var traveledDistance: Double = 0
    var flag: Bool = false
    var data: Any?
    var avgSpeed: Double = 0
    var stopGo: Bool = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultsViewController =  segue.destination as? ResultsViewController{
            resultsViewController.distance = traveledDistance
            resultsViewController.avgspeed = avgSpeed
            resultsViewController.time = timeLabel.text!
            resultsViewController.weight = Double(weight!)
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if stopGo == true {
            performSegue(withIdentifier: "results", sender: data)
            flag = false
        }
        if stopGo == false {
            startButton.setTitle("STOP", for: .normal)
            startButton.backgroundColor = UIColor.red
            flag = true
            stopGo = true
        }
    }

    
    func updateTime (time: Double)
    {
        let hour = Int(time / 3600)
        let minute = Int((time - Double(hour) * 3600) / 60)
        let sec = Int(time - Double(hour * 3600) - Double(minute * 60))
        print(hour, minute, sec)
        timeLabel.text = String(format: "%02i:%02i:%02i", hour, minute, sec)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.0025, 0.0025)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        
        lbl2.text = String(format: "%.1f", location.speed * 2.23693629) + " mph"
        
        ///////// Calculation Part///////////////////////////////
        if flag {
            if startDate == nil {
                startDate = Date()
            } else {
                updateTime(time: Date().timeIntervalSince(startDate))
                print("elapsedTime:", String(format: "%.0fs", Date().timeIntervalSince(startDate)))
            }
            if startLocation == nil {
                startLocation = locations.first
            } else if let location = locations.last {
                traveledDistance += lastLocation.distance(from: location)
                distance.text = String(format: "%.0f", floor(traveledDistance)) + " m"
                print("Traveled Distance:",  traveledDistance)
                //            print("Straight Distance:", startLocation.distance(from: locations.last!))
            }
            lastLocation = locations.last
            avgSpeed = traveledDistance / Date().timeIntervalSince(startDate)
            avgSpeedLabel.text = String(format: "%.2f MPH", avgSpeed * 2.23693629)
        //////////////////////////////////////////////////
        }
        
    }
    
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

