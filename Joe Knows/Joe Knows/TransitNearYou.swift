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
 
    
    var distanceOrder = [(name: String, value: Double)]()
    
    var clicked = 10
    
   
    
//    init(proximityUUID: uuid, identifier: "First Beacon")
//    var bRegion = CLBeaconRegion
//    self.locMan.startMonitoringForRegion(beaconRegion)
//
    @IBOutlet weak var ClosestTransit: UIButton!
    @IBOutlet weak var SecondClosestTransit: UIButton!
    @IBOutlet weak var ThirdClosestTransit: UIButton!
    @IBOutlet weak var FarthestTransit: UIButton!
    
    @IBAction func ClosestTransit(_ sender: Any) {
        
    }
    
    
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
    
    
    @IBAction func TransitDirections1(_ sender: UIButton!) {
        clicked = 0
        performSegue(withIdentifier: "TransitDirections", sender: self)
        
    }
   
@IBAction func TransitDirections2(_ sender: UIButton!) {
        clicked = 1
        performSegue(withIdentifier: "TransitDirections", sender: self)
    
    }
    
    @IBAction func TransitDirections3(_ sender: UIButton!) {
        clicked = 2
        performSegue(withIdentifier: "TransitDirections", sender: self)
        
    }
    @IBAction func TransitDirections4(_ sender: UIButton!) {
        clicked = 3
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
        print("now am here")
        orderLocs()
        print("got here")
        fillButtons()
        print("here now too!!")
        showLocations()
        //showTransit()
        
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
    
    func getCoordinate(latitude:Double , longitude:Double ) -> CLLocationCoordinate2D{
        let lat = latitude
        let lon = longitude
        
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
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }

    func orderLocs(){
        //TODO: put in the right uuid string for this beacon!
        
        var count = 0
        let UUIDs : [String] = ["2EFEC265-F897-48BE-B9F8-3CAE9597294E","90811294-B5FD-454A-BF0A-272650EA7860","29F35B05-084A-4AF4-9F64-A92F411CEA41","73EEB531-EBF8-4495-A9E0-1E5316D2E6CF","FA33023B-E968-43FB-8E79-A2B9E3CA01A9","U72EBB70C-D806-4D40-B742-64D9346D0DD8","76A1827E-4EE5-4CC9-B12E-5ED12963399B"]
        print("yoooo")
        print(UUIDs)
        print(BeaconSet.beacon.values)
        BeaconSet.beaconSet(ID: UUIDs)
        print(BeaconSet.beacon)
        for key in BeaconSet.beacon.values{
            print("am I in this loop?!")
            let u = UUIDs[count]
            let lat = key.getCoordLat()!
            let long = key.getCoordLon()!
            let loc:CLLocation = CLLocation.init(latitude: lat, longitude: long)
            print(UUIDs)
            print(distanceOrder.count)
            print(distanceOrder.capacity)
            let dis = userLocation.distance(from: loc)
            let item:(String,Double)=(u,dis)
            distanceOrder.append(item)
            print("screw you")
            print(distanceOrder)
            print(item)
            print(distanceOrder.count)
//            distanceOrder[count] = (u, userLocation.distance(from: loc))
           // print(distanceOrder)
            //at this point, distance order is unordered (in same order as was inputted into list)
            
            count += 1
        }
        
    for i in distanceOrder.indices {
        print("why can't code just work?!")
        if(i == 6){
            break}
        print(distanceOrder[i])
        var next = distanceOrder.index(after: i)
        print(i)
        print(distanceOrder.index(after: i))
        print(distanceOrder[next])
        
    if(distanceOrder[i] > distanceOrder[next]){
        
    print(distanceOrder[i] > distanceOrder[next])
    print(distanceOrder)
        
    let hold = distanceOrder[i]
    
    
    distanceOrder[i] = distanceOrder[next]
    distanceOrder[next] = hold
    print("check order change")
    print(distanceOrder)
    print(distanceOrder[i])
    print(distanceOrder[next])
        
    print(distanceOrder[i] > distanceOrder[next] )
        
    }
    }
    BeaconSet.setDistanceOrder(dO: distanceOrder)
//        let uuid = UUID(uuidString: "CB01A845-55DC-4551-8FDB-D0318752CC1D")!
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "First Beacon")
//        locationManager.startMonitoring(for: beaconRegion)
//        locationManager.startRangingBeacons(in: beaconRegion)
//
//
    }
    
//    func startScan(){
//        print(u == nil)
//        var uuid = UUID.init(uuidString: u)
//        let uuid = NSUUID.init(uuidString: u)
//        print("wya")
//        print(uuid?.uuidString)
//        print(uuid!)
//
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid! as UUID, identifier: key.getName()!)
//        locationManager.startMonitoring(for: beaconRegion)
//        locationManager.startRangingBeacons(in: beaconRegion)
//    }
    var n0 = ""
    var n1 = ""
    var n2 = ""
    var n3 = ""
    
    func fillButtons(){
        print("distanceOrder")
        print(distanceOrder)
        n0 = (BeaconSet.beacon[distanceOrder[0].name]?.getName())!
        n1 = (BeaconSet.beacon[distanceOrder[1].name]?.getName())!
        n2 = (BeaconSet.beacon[distanceOrder[2].name]?.getName())!
        n3 = (BeaconSet.beacon[distanceOrder[3].name]?.getName())!
        //TODO: Check this logic
       
        
        
ClosestTransit.setTitle(n0, for: .normal)
                print("hey")
SecondClosestTransit.setTitle(n1, for: .normal)
                print("yo")
ThirdClosestTransit.setTitle(n2, for: .normal)
                print("hello")
FarthestTransit.setTitle(n3, for: .normal)
                print("ahhhh")
       
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

    func showLocations(){
        print("hey this might be working, wild!")
        for key in BeaconSet.beacon.keys{
            
            //TO DO: Show only locations that are listed?
            let val = BeaconSet.beacon[key]
            let lon = val?.getCoordLon()
            let lat = val?.getCoordLat()
            print(val?.getName())
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = self.getCoordinate(latitude: lat!, longitude: lon!)
        myAnnotation.title = val?.getName()
        self.mapView.addAnnotation(myAnnotation)
        self.annotations.append(myAnnotation)
    }
        self.mapView.showAnnotations(self.annotations, animated: false)
        self.mapView.sizeToFit()
       
    }
    
    
    // MARK: - Navigation

   //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TransitDirections"){
            
//            let (sender as? UIButton)?.segue.
            let VC = segue.destination as! TransitNavigation
//            let bT = (sender as? UIButton)?.currentTitle
//                print("b flipping T")
//                print(bT)
//                if(bT == n0){
//                    VC.buttonIndex = 0
//                }
//                else if(bT == n1){
//                    VC.buttonIndex = 1
//                }
//                else if(bT == n2){
//                    VC.buttonIndex = 2
//                }
//                else if(bT == n3){
//                    VC.buttonIndex = 3
//                }
//
//
            VC.buttonIndex = clicked
            print("clicked")
            print(clicked)
            print(VC.buttonIndex)
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

//extension BeaconSet{
//   func getBeaconID() -> String{
//    return ID
//    }
//    mutating func setBeaconID(id: String){
//        ID = id
//        uuid = UUID(uuidString:ID) ?? uuid
//    }
//}
