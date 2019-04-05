//
//  CurrentLocationViewController.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/3/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit

class CurrentLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true;
        
        // Do any additional setup after loading the view.
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func MainToLoading(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "MainToLoading", sender: self)
    }
}
