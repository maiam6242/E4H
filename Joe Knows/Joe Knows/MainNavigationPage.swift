//
//  MainNavigationPage.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit

//Global Variable:
var locationManagerWrapped = locationManagerWrapper()

class MainNavigationPage: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Setting up view
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerWrapped.setDelegate(currentClass: self)
    }

    
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    var userLocationOld:CLLocation? = nil
    var mapV: MKMapView!
    var locationManager : CLLocationManager!
    let geocoder = CLGeocoder()
    
    @IBAction func Navigate(_ sender: Any) {
        performSegue(withIdentifier: "Navigate", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManagerWrapped.determineCurrentLocation()
    }
    
    //Creating the background map
    func createMapView(){
        let mapObject = map.init(actualScreenView: view)
        mapV = mapObject.mapView
    }
    
    //Determining the user's current location
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapV.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        getAddress(userLocation: userLocation)
        
        myAnnotation.title = "Current location"
        mapV.addAnnotation(myAnnotation)
    }
    
    func getAddress(userLocation:CLLocation){
        
        if(userLocation == userLocationOld){
            return
        }
        else{
            userLocationOld = userLocation
        geocoder.reverseGeocodeLocation(userLocation) {(placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error, userLocation: userLocation)
            }
        }
    }
    
    //Setting currentLocationLabel to user's current location
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?, userLocation:CLLocation){
        
            if let placemarks = placemarks, let placemark = placemarks.first {
                currentLocationLabel.text = placemark.compactAddress
            }
            else{
                currentLocationLabel.text = "No matching Addresses Found"
            }
        }
}

extension CLPlacemark{
   var compactAddress: String?{
        if let name = name{
            var result = name
            
            if let street = thoroughfare{
                result += ", \(street)"
            }
            if let city = locality{
                result += ", \(city)"
            }
            if let country = country{
                result += ", \(country)"
            }
            return result
        }
        return nil
    }
    
}

