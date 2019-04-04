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
    
    /*
    @IBAction func goToMainPage(sender: Any) {
            print("click")
        //self.performSegue(withIdentifier: "LoadingToMain", sender: self)
    }
 */

<<<<<<< HEAD
=======
    @IBOutlet weak var mapView: MKMapView!
>>>>>>> 3372ad505e5c2f35b1c49d2230a046a398b123fa
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("view loaded")
    }
    
    @IBAction func LoadingToMain(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "LoadingToMain", sender: self)
    }
    
}


