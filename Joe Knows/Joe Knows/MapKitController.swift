//
//  MapKitController.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/3/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation
import MapKit

class MapKitController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    @IBAction func userLocation(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ _manager:CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 500,longitudinalMeters: 500)
        
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.startUpdatingLocation()
    }
    
}
