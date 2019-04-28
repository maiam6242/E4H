//
//  MainNavigationPage.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit

class MainNavigationPage: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Setting up
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var currentLocationLabel: UILabel!
    
    var userLocationOld:CLLocation? = nil
    var mapView: MKMapView!
    var locationManager : CLLocationManager!
    
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
        determineCurrentLocation()
    }
    
    //Creating the background map
    func createMapView(){
        mapView = MKMapView()
        mapView.isAccessibilityElement = false
        
        let leftMargin:CGFloat = 1
        let topMargin:CGFloat = 1
        let mapWidth:CGFloat = view.frame.size.width-6
        let mapHeight:CGFloat = view.frame.size.height-10
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = false
        
        //creating and placing a compass
        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .visible
        mapView.addSubview(compassButton)
        view.bringSubviewToFront(compassButton)
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
        compassButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 12).isActive = true
        
        mapView.center = view.center
        
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
    }
    
    //Determining the user's current location
    func determineCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        getAddress(userLocation: userLocation)
        
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }
    
    func getAddress(userLocation:CLLocation){
        let geocoder = CLGeocoder()
        
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
    
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

