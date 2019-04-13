//
//  TransitNearYou.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit
import CoreBluetooth
import CoreLocation


class TransitNearYou: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    var mapView: MKMapView! = MKMapView.init()
    var locationManager : CLLocationManager! = CLLocationManager.init()
    var annotations = [MKPointAnnotation]()
//    var centralManager:CBCentralManager!
//    var sensorTag:CBPeripheral?
 
    
    var distanceOrder = [String : Double]()
    func startScanning(){
        //TODO: put in the right uuid string for this beacon!
        
        var count = 0
        let UUIDs : [String] = ["UUID1","UUID2","UUID3","UUID4","UUID5","UUID6","UUID7"]
        for key in BeaconSet.beacon.values{
           
            let u = UUIDs[count]
            let lat = key.getCoordLat()!
            let long = key.getCoordLon()!
            let loc:CLLocation = CLLocation.init(latitude: lat, longitude: long)
            distanceOrder[u] = userLocation.distance(from: loc)
            
            
            for i in 0...6{
                
                if(distanceOrder[UUIDs[i]]! > distanceOrder[UUIDs[i+1]]!){
                    let hold = distanceOrder[UUIDs[i]]
                    distanceOrder[UUIDs[i]] = distanceOrder[UUIDs[i+1]]
                    distanceOrder[UUIDs[i+1]] = hold
                    print(distanceOrder)
                }
            }
            
            let uuid = UUID(uuidString: u)!
            let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: key.getName()!)
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(in: beaconRegion)
            count += 1
        }
        
    let uuid = UUID(uuidString: "CB01A845-55DC-4551-8FDB-D0318752CC1D")!
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "First Beacon")
    locationManager.startMonitoring(for: beaconRegion)
    locationManager.startRangingBeacons(in: beaconRegion)
        
        
    }
    
//    init(proximityUUID: uuid, identifier: "First Beacon")
//    var bRegion = CLBeaconRegion
//    self.locMan.startMonitoringForRegion(beaconRegion)
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        centralManager = CBCentralManager(delegate: self, queue: nil)
        // Do any additional setup after loading the view.
        
    }
    
//    func centralManagerDidUpdateState(central: CBCentralManager){
//        switch central.state{
//        case .poweredOn:
//            keepScanning = true
//            _ = Timer(timeInterval: timerScanInterval, targe: self, selector: #selector(pauseScan), userInfo: nil, repeats: false)
//            centralManager.scanForPeripherals(withServices: nil, options: nil)
//        case .poweredOff:
//            state = "Bluetooth on this device is currently powered off."
//        case .unsupported:
//            state = "This device does not support BLE."
//        case .unauthorized:
//            state = "This app is not authorized to use BLE."
//        case .resetting:
//            state = "The BLE manager is resetting; a state update is pending"
//        case .unknown:
//            state = "The state of the BLE Manager is unknown."
//        @unknown default:
//
//        }
//   }
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
        startScanning()
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
    
    var userLocation:CLLocation = CLLocation.init()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        userLocation = locations[0] as CLLocation
        
        //
        //       let currentLocationLabel: UILabel!
        //        currentLocationLabel.text = "coordinates: and \(userLocation.coordinate.latitude)"
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        if beacons.count > 0{
            let beacon = beacons[0]
            update(distance: beacon.proximity)
        } else{
            update(distance: .unknown)
        }
        
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
    
    func update(distance: CLProximity){
        switch distance{
        case .unknown:
            print("WHO EVEN KNOWS?!")
        case .far:
            print("OOF THAT'S REALLY FAR")
        case .near:
            print("DUDE, YOU'RE CLOSE")
        case .immediate:
            print("WOAH, GET OFF, YOU'RE RIGHT ON TOP OF ME")
        @unknown default:
            print("YIKES, YOU SHOULD KNOW THIS")
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

extension BeaconSet{
   func getBeaconID() -> String{
    return ID
    }
    mutating func setBeaconID(id: String){
        ID = id
        uuid = UUID(uuidString:ID) ?? uuid
    }
}
