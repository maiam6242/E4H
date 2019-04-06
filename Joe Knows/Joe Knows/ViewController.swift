//
//  ViewController.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/3/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//
import MapKit
import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var LoadingToMain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view loaded")
    }
    
    @IBAction func LoadingToMain(_ sender: Any) {
        print("button pressed")
        performSegue(withIdentifier: "LoadingToMain", sender: self)
    }
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus()
        {
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse || CLLocationManager.authorizationStatus() != .authorizedAlways {
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }



