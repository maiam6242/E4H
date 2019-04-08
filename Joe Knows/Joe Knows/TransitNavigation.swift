//
//  TransitNavigation.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit


class TransitNavigation: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var userLocation: CLLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let request = MKDirections.Request()
        let uL = MainNavigationPage.init()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate:uL?.coordinate ?? nil))
        if request.source == nil
        {
            
        }
        print(request.source)
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:40,longitude: 30)))
        print(request.destination)
        request.requestsAlternateRoutes = true
        request.transportType = .transit
        
        let directions = MKDirections(request:request)
        directions.calculate{ (response, error) in guard let unwrappedResponse = response else {return}
        
            print(directions)
            
            for route in unwrappedResponse.routes{
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                //                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }}
            
        
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TransitDirectionsBack(_ sender: Any) {
        performSegue(withIdentifier: "DirectionsToNav", sender: self)
    }
    
    @IBAction func DirectionsExt(_ sender: Any) {
        performSegue(withIdentifier: "DirectionsExtNext", sender: self)
        
    }
//    var mapView: MKMapView!
//    var locationManager : CLLocationManager!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate:CLLocationCoordinate2D(latitude: MKUserLocation.init().coordinate.latitude, longitude: MKUserLocation.init().coordinate.longitude)))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:40,longitude: 30)))
//        request.requestsAlternateRoutes = true
//        request.transportType = .transit
//
//        let directions = MKDirections(request:request)
//        directions.calculate{ (response, error) in guard let unwrappedResponse = response else {return}
//
//            for route in unwrappedResponse.routes{
//                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
////                self.mapView.addOverlay(route.polyline)
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
           }
//
//        }
        
//    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(!animated)
        //createMapView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(!animated)
        determineCurrentLocation()
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
        //
        //       let currentLocationLabel: UILabel!
        //        currentLocationLabel.text = "coordinates: and \(userLocation.coordinate.latitude)"
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: false)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
        
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
