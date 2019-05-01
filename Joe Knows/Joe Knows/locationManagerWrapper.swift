//
//  locationManagerWrapper.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/30/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation
import CoreLocation

struct locationManagerWrapper {
    var locationManager : CLLocationManager!
    
    
    init(){
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func setDelegate(currentClass : CLLocationManagerDelegate){
        locationManager.delegate = currentClass
        
    }
    func determineCurrentLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
}
