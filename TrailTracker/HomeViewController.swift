//
//  HomeViewController.swift
//  TrailTracker
//
//  Created by Madin Kim on 3/15/18.
//  Copyright © 2018 VinceReyes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func goBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "MapSegue", sender: weightTextField.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = weightTextField.text!
        if let MapViewController = segue.destination as? MapViewController{
            MapViewController.weight = data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.placeholder = "years old"
        weightTextField.placeholder = "lbs"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSegueFromResultViewController (_ sender: UIStoryboardSegue) {
//        print("This is unwind")
    }

}
