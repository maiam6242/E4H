//
//  TransitNearYou.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit


class TransitNearYou: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var annotations = [MKPointAnnotation]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func BackToMainNav(_ sender: Any) {
        performSegue(withIdentifier: "BackToMainNav", sender: self)
    }
    
    @IBAction func TransitDirections(_ sender: Any) {
        performSegue(withIdentifier: "TransitDirections", sender: self)
    }
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
        showTransit()
        
    }
    
    func showTransit(){
        let request2 = MKLocalSearch.Request()
        
        request2.naturalLanguageQuery = "Metro West Transit Authority"
        request2.region = mapView.region
        
        
        let search = MKLocalSearch(request: request2)
        search.start{(response, error) in guard let response = response else{
            print("Search error: \(error)")
            return
            }
            for item in response.mapItems{
                print(item)
                let myAnnotation: MKPointAnnotation = MKPointAnnotation()
                myAnnotation.coordinate = self.getCoordinate(item: item)
                myAnnotation.title = item.name
                self.mapView.addAnnotation(myAnnotation)
                self.annotations.append(myAnnotation)
            }
            
            self.mapView.showAnnotations(self.annotations, animated: false)
        }
        
    }
    
    func getCoordinate(item: MKMapItem) -> CLLocationCoordinate2D{
        let lat = item.placemark.coordinate.latitude
        let lon = item.placemark.coordinate.longitude
        
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
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
        
//        mapView.addOverlay(transit)
        
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
        let myAnnotation2: MKPointAnnotation = MKPointAnnotation()
        myAnnotation2.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        myAnnotation2.title = "Current location"
//        let pin = MKPinAnnotationView(annotation: myAnnotation2, reuseIdentifier: myAnnotation2.title)
        print(myAnnotation2)
//        pin.pinTintColor = UIColor.blue
        mapView.addAnnotation(myAnnotation2)
        annotations.append(myAnnotation2)
        self.mapView.showsTraffic = true
        
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
