//
//  BeaconNavigation.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit
import CoreBluetooth
import CoreLocation
import AudioToolbox


class BeaconNavigation: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, CBPeripheralDelegate {
    
    var whereTo:CBPeripheral?
    var centralManager:CBCentralManager!
   // var currentRSSI:Int = 0
    var oldVal1:Int = 0
    var oldVal2:Int = 0
    var oldVal3:Int = 0
    var avgVal:Int = 0
    var oldRSSI:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate:self,queue: nil)
        print("where flippin to?!")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        print(beaconLoc == whereTo)
        print(beaconLoc?.identifier as Any)
        print(whereTo?.identifier as Any)
        print(whereTo?.name as Any)
        centralManager.connect(beaconLoc!, options: nil)
        print(beaconLoc?.state as Any)
        
        
        print(BeaconSet.beacon[beaconLoc!.identifier.uuidString]?.getName() as Any)
        beaconLoc?.readRSSI()
        print(centralManager.isScanning)
        print(centralManager as Any)
        print(beaconLoc as Any)
        print(beaconLoc?.readRSSI() as Any)
        destination.text = BeaconSet.beacon[beaconLoc!.identifier.uuidString]?.getName()
        
       
        // destination.text
        // Do any additional setup after loading the view.
        //if ()
    }
    

    
    @IBOutlet weak var destination: UILabel!
    
    
    
    @IBAction func BeaconNavBack(_ sender: Any) {
        performSegue(withIdentifier: "BeaconNavBack", sender: self)
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
        
        if (currentRSSI > -40 && currentRSSI != 0){
            self.performSegue(withIdentifier: "SecretArrival", sender: self)
        }
        
    
        //determineVib()
        
    }
//    @IBAction func SecretArrival(_ sender: Any) {
//        performSegue(withIdentifier: "SecretArrival", sender: self)
//        
//    }
//   

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
        
        
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
        

    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("*****************************")
        print("Connection complete")
        print("Peripheral info: \(beaconLoc ?? <#default value#>)")
        print(beaconLoc?.readRSSI() as Any)
        
        //Stop Scan- We don't need to scan once we've connected to a peripheral. We got what we came for.
       centralManager?.stopScan()
       print("Scan Stopped")
        
        //Erase data that we might have
        
        
        //Discovery callback
        peripheral.delegate = self
        //Only look for services that matches transmit uuid
        
        print("do beacons work?! asking for a friend...")
        print(peripheral.readRSSI())
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func determineVib(){
//        if(oldVal1 == 0){
//            oldVal1 = currentRSSI
//            print("hey dude, at the oldVal1")
//            print(oldVal1)
//        }
//        else if(oldVal2 == 0){
//            oldVal2 = currentRSSI
//            print("hey dude, at the oldVal2")
//            print(oldVal2)
//        }
//        else if(oldVal3 == 0){
//            oldVal3 = currentRSSI
//            print("hey dude, at the oldVal3")
//            print(oldVal3)
//        }
//        if(oldVal1 != 0 && oldVal2 != 0 && oldVal3 != 0){
//            avgVal = (oldVal1 + oldVal2 + oldVal3)/3
//            print("hey dude, at the avgVal")
//            print(avgVal)
//
//            oldVal3 = oldVal2
//            oldVal2 = oldVal1
//            oldVal1 = currentRSSI
//        }
//
//        if(avgVal > currentRSSI){
//            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//        }
//
//    }
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("What if the RSSI worked?!")
        peripheral.readRSSI()
        print(RSSI.intValue)
        print("aghh beacons!!!")
        currentRSSI = RSSI.intValue
        print(peripheral.readRSSI())
        print("or here")
        determineVib()
        print("Is it stopping here?")
    }
    func determineVib(){
        print("k, vib")
        if (oldVal1 == 0){
            oldVal1 = currentRSSI
            print("hey dude, at the oldVal1")
            print(oldVal1)
        }
        else if(oldVal2 == 0){
            oldVal2 = currentRSSI
            print("hey dude, at the oldVal2")
            print(oldVal2)
        }
        else if(oldVal3 == 0){
            oldVal3 = currentRSSI
            print("hey dude, at the oldVal3")
            print(oldVal3)
        }
        if(oldVal1 != 0 && oldVal2 != 0 && oldVal3 != 0){
            avgVal = (oldVal1 + oldVal2 + oldVal3)/3
            print("hey dude, at the avgVal")
            print(avgVal)
            
            oldVal3 = oldVal2
            oldVal2 = oldVal1
            oldVal1 = currentRSSI
        }
        
        if(avgVal > currentRSSI){
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
    }
    
    @objc func cancelScan() {
        centralManager?.stopScan()
        print("Scan Stopped")
        
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        peripheral.delegate = self
        print("cool cool")
        print(peripheral.name as Any)
        
    }
    func startScan() {
        print("Now Scanning...")
        centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
        print("what if thiS worked?!")
        print(centralManager.isScanning)
        print(centralManager.state)
        
        Timer.scheduledTimer(timeInterval: 1700, target: self, selector: #selector(self.cancelScan), userInfo: nil, repeats: false)}

}

extension BeaconNavigation: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .poweredOn:
            print("central.state is .poweredOn")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .unsupported:
            print("central.state is .unsupported")
        case .resetting:
            print("central.state is .resetting")
        case .unauthorized:
            print("central.state is .unauthorized")
        @unknown default:
            print("central.state is .default")
        }
    }
    
//    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
//        print("What if the RSSI worked?!")
//        peripheral.readRSSI()
//        print(RSSI.intValue)
//        print("aghh beacons!!!")
//        currentRSSI = RSSI.intValue
//        print(peripheral.readRSSI())
//        print("or here")
//        determineVib()
//        print("Is it stopping here?")
//    }
//    func determineVib(){
//        print("k, vib")
//        if(oldVal1 == 0){
//            oldVal1 = currentRSSI
//            print("hey dude, at the oldVal1")
//            print(oldVal1)
//        }
//        else if(oldVal2 == 0){
//            oldVal2 = currentRSSI
//            print("hey dude, at the oldVal2")
//            print(oldVal2)
//        }
//        else if(oldVal3 == 0){
//            oldVal3 = currentRSSI
//            print("hey dude, at the oldVal3")
//            print(oldVal3)
//        }
//        if(oldVal1 != 0 && oldVal2 != 0 && oldVal3 != 0){
//            avgVal = (oldVal1 + oldVal2 + oldVal3)/3
//            print("hey dude, at the avgVal")
//            print(avgVal)
//
//            oldVal3 = oldVal2
//            oldVal2 = oldVal1
//            oldVal1 = currentRSSI
//        }
//
//        if(avgVal > currentRSSI){
//            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//        }
//
//    }
//
//    @objc func cancelScan() {
//        centralManager?.stopScan()
//        print("Scan Stopped")
//
//    }
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
//
//        peripheral.delegate = self
//        print("cool cool")
//        print(peripheral.name)
//
//    }
//    func startScan() {
//        print("Now Scanning...")
//        centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
//        print("what if thiS worked?!")
//        print(centralManager.isScanning)
//        print(centralManager.state)
//
//        Timer.scheduledTimer(timeInterval: 1700, target: self, selector: #selector(self.cancelScan), userInfo: nil, repeats: false)}
}
