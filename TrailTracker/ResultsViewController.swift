//
//  ResultsViewController.swift
//  TrailTracker
//
//  Created by Madin Kim on 3/15/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import UIKit



class ResultsViewController: UIViewController {
    var distance: Double?
    var weight: Double?
    var time: String?
    var avgspeed: Double?

    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avgspeedLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLabel.text = "Total Distance: " + String(format: "%.0f", distance!) + " meters"
        weightLabel.text = "Total Calories Burned: " + String(format: "%.0f", (0.63 * weight! * 1.6 * distance! / 1000))
        timeLabel.text = "Total Time: " + time!
        avgspeedLabel.text = "Average Speed: " + String(format: "%.2f", avgspeed!) + " mph"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

protocol trailTrackerDelegate: class {
    func startButtonPressed(from: ResultsViewController, with text: String)
    
}
