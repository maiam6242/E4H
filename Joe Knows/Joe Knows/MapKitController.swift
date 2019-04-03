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

    var locationManager = CLLocationManager()
    
    func userLocation(){
        // If the user has authorized the location to be used, starts finding that location, if not asks the user for authorization
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
