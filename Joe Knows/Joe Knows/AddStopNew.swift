//
//  AddStopNew.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/7/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit

class AddStopNew: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var currentLocationLabel: UILabel!
    
        var userLocationOld:CLLocation? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func AddStopNewBack(_ sender: Any) {
        performSegue(withIdentifier: "AddStopNo", sender: self)
    }
    
    @IBAction func AddStopNewNo(_ sender: Any) {
        performSegue(withIdentifier: "AddStopNo", sender: self)
    }
    @IBAction func AddStopNewYes(_ sender: Any) {
        performSegue(withIdentifier: "YesAddStop", sender: self)
    }
    var mapView: MKMapView!
    var locationManager : CLLocationManager!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(!animated)
        
        createMapView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(!animated)
        determineCurrentLocation()
        
        
    }
   
    func createMapView(){
        mapView = MKMapView()
        
        let leftMargin:CGFloat = 1
        let topMargin:CGFloat = 1
        let mapWidth:CGFloat = view.frame.size.width-6
        let mapHeight:CGFloat = view.frame.size.height-10
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        mapView.center = view.center
        
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
    }
    
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

        mapView.setRegion(region, animated: false)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
 
        getAddress(userLocation: userLocation)
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
            
      
        //return p
    
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
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?, userLocation:CLLocation){
        if let error = error {
            //print("Unable to reverse geocode")
            currentLocationLabel.text = "Coordinates: \(userLocation.coordinate.latitude) and \(userLocation.coordinate.longitude)"
        }
        else{
            if let placemarks = placemarks, let placemark = placemarks.first {
                currentLocationLabel.text = placemark.compactAddress
            }
            else{
                currentLocationLabel.text = "No matching Addresses Found"
            }
        }
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
//}
