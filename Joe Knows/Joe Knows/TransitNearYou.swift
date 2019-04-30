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
import AudioToolbox

var beaconLoc:CBPeripheral?
var currentRSSI: Int = 0
var centralManager1:CBCentralManager!

class TransitNearYou: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, CBPeripheralDelegate, CBCentralManagerDelegate{
    var mapView: MKMapView! = MKMapView.init()
    var locationManager : CLLocationManager! = CLLocationManager.init()
    var annotations = [MKPointAnnotation]()
   // var centralManager:CBCentralManager!
    var RSSIs = [NSNumber]()
    var data = NSMutableData()
    var writeData: String = ""
    var peripherals: [CBPeripheral] = []
    var characteristicValue = [CBUUID: NSData]()
    var timer = Timer()
    var characteristics = [String : CBCharacteristic]()
    var blePeripheral : CBPeripheral?
    var navTo : CBPeripheral?
    var distanceOrder = [(name: String, value: Double)]()
    var clicked = 0
    
   
    var oldRSSI:Int = 0
    let RSSITHRESHOLD:Int = 2
    
    @IBOutlet weak var ClosestTransit: UIButton!
    @IBOutlet weak var SecondClosestTransit: UIButton!
    @IBOutlet weak var ThirdClosestTransit: UIButton!
    @IBOutlet weak var FarthestTransit: UIButton!
    
    @IBAction func ClosestTransit(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager1 = CBCentralManager(delegate: self, queue: nil)

        // Do any additional setup after loading the view.
    
    }
    

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            // We will just handle it the easy way here: if Bluetooth is on, proceed...start scan!
            print("Bluetooth Enabled")
            startScan()
            
        } else {
            //If Bluetooth is off, display a UI alert message saying "Bluetooth is not enable" and "Make sure that your bluetooth is turned on"
            print("Bluetooth Disabled-- Make sure your Bluetooth is turned on")
            
            let alertVC = UIAlertController(title: "Bluetooth is not enabled", message: "Make sure that your bluetooth is turned on", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func moveScreens(){
        print("is this going to move?!")
        let BeNav = storyboard!.instantiateViewController(withIdentifier: "BeaconNavigation") as! BeaconNavigation
        self.present(BeNav, animated: true, completion: nil)

    }
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Stop Scanning")
        centralManager1?.stopScan()
    }
    
    func disconnectFromDevice () {
        if blePeripheral != nil {
            // We have a connection to the device but we are not subscribed to the Transfer Characteristic for some reason.
            // Therefore, we will just disconnect from the peripheral
            centralManager1?.cancelPeripheralConnection(blePeripheral!)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("*****************************")
        print("Connection complete")
        print("Peripheral info: \(String(describing: blePeripheral))")
        print(blePeripheral?.readRSSI() as Any)
        //Stop Scan- We don't need to scan once we've connected to a peripheral. We got what we came for.
        //centralManager?.stopScan()
        print("Scan Stopped")
        
        //Erase data that we might have
        data.length = 0
        
        //Discovery callback
        peripheral.delegate = self
        //Only look for services that matches transmit uuid
//        peripheral.discoverServices([CBUUID(string: "48B3ED5E-7D68-4871-907B-B91D3B52952A")])
        print("do beacons work?! asking for a friend...")
        //print(peripheral.readRSSI())
        
        
        }
    
    func connectToDevice () {
        centralManager1?.connect(blePeripheral!, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if error != nil {
            print("Failed to connect to peripheral")
            return
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("What if the RSSI worked?!")
        peripheral.readRSSI()
        print(RSSI.intValue)
        
        print("wild, is this where it is being read from?")
        currentRSSI = RSSI.intValue
        
        
        if(RSSI.intValue < oldRSSI)
            //RSSI.intValue.distance(to: oldRSSI) > RSSITHRESHOLD &&
            
        {
            print("hey, could you just work? thanks")
            print(switchScreen)
//            if(switchScreen){
//                print("yo what if this janky way worked?")
//                let ArrNav = storyboard!.instantiateViewController(withIdentifier: "ArrivalConfirmation") as! ArrivalConfirmation
//                self.present(ArrNav, animated: true, completion: nil)
//            }
            if(switchScreen){
            self.performSegue(withIdentifier: "FinalArrival", sender: self)
            print("hey so did I get in here?!")
                

                print("yo can you please just move?! No one likes you!!")
                centralManager1?.stopScan()
            }
            
            print("ok, we're closer. This should really be a &&, but here we are, thanks swift")
            
            applyStats()
            
//            if(currentRSSI.magnitude - oldRSSI.magnitude < RSSITHRESHOLD){
//                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//                //            oldRSSI = currentRSSI
//            }
            
        }
        
        if(currentRSSI.magnitude < 40 && currentRSSI != 0){
            switchScreen = true
            //self.performSegue(withIdentifier: "Arrival", sender: self)
           centralManager1?.stopScan()
        }
        
        print(oldRSSI)
        print(oldRSSI.magnitude)
        print(currentRSSI)
        print(currentRSSI.magnitude)
        oldRSSI = currentRSSI
        
        
    }
    var oldVal1:Int = 0
    var oldVal2:Int = 0
    var oldVal3:Int = 0
    var avgVal:Int = 0
    var avgValNoOutliers:Int = 0
    func applyStats(){
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
            if((oldVal1 - avgVal).magnitude > 10){
                avgValNoOutliers = (oldVal2 + oldVal3)/2
            }
            else if((oldVal2 - avgVal).magnitude > 10){
                avgValNoOutliers = (oldVal1 + oldVal3)/2
            }
            else if((oldVal3 - avgVal).magnitude > 10){
                avgValNoOutliers = (oldVal1 + oldVal2)/2
            }
            else{
                avgValNoOutliers = avgVal
            }
            print(avgVal)
            print(avgValNoOutliers)
            print("I want to go to bed")
            
            oldVal3 = oldVal2
            oldVal2 = oldVal1
            oldVal1 = currentRSSI
        }
        
        if(avgValNoOutliers < currentRSSI){
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if(identifier == "FinalArrival"){
            // segue_identifier is the viewController and storyBoard Reference segue identifier.
            print("hello")
        }
        return true;
    }
    
    func disconnectAllConnection() {
        centralManager1.cancelPeripheralConnection(blePeripheral!)
    }
    
    func centralManager(central: CBCentralManager,
                        didConnectPeripheral peripheral: CBPeripheral)
    {
        print("connected!")
    }
    // Called when it failed
    private func centralManager(central: CBCentralManager,
                        didFailToConnectPeripheral peripheral: CBPeripheral,
                        error: NSError?)
    {
        print("failed…")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        disconnectFromDevice()
        super.viewDidAppear(!animated)
        determineCurrentLocation()
        print("now am here")
        orderLocs()
        print("got here")
        fillButtons()
        print("here now too!!")
        startScan()
        showLocations()
        print("just kiddin'")
    
        if(switchScreen){
            print("yo what if this janky way worked?")
            let ArrNav = storyboard!.instantiateViewController(withIdentifier: "ArrivalConfirmation") as! ArrivalConfirmation
            self.present(ArrNav, animated: true, completion: nil)
        }
        print(blePeripheral?.name as Any)
        print(peripherals.count)
        
        //showTransit()
        
    }


    func showTransit(){
        let request2 = MKLocalSearch.Request()
        
        request2.naturalLanguageQuery = "Metro West Transit Authority"
        request2.region = mapView.region
        
        
        let search = MKLocalSearch(request: request2)
        search.start{(response, error) in guard let response = response else{
            print("Search error: \(String(describing: error))")
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
    
    func restoreCentralManager() {
        //Restores Central Manager delegate if something went wrong
        centralManager1?.delegate = self
    }
    
    
    func determineCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            print("services enabled")
            locationManager.startUpdatingLocation()
        }
    }
    
    var userLocation:CLLocation = CLLocation.init()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        userLocation = locations[0] as CLLocation
        print("beacons are the worst")
        print(CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self))
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
            print("hey its available!")
        }
        else{
            print("shit, we can't get beacon")
            
        }
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
        
        update(distance: beacons[0].proximity)
    }

    func orderLocs(){
        //TODO: put in the right uuid string for this beacon!
        
        var count = 0

        print("yoooo")
//        print(UUIDs)
        BeaconSet.beaconSet()
        print(BeaconSet.beacon)
        print("how many values are actually here, dude?!")
        print(BeaconSet.beacon.values.count)
        for index in BeaconSet.beacon.indices{
            print("there are definitely seven values, you're just stupid")
//            for key in BeaconSet.beacon.values{
//                print("hey, what if you just worked? Asking for a friend...")
//                print(key)
//            }
            
            print("am I in this loop?!")
            
            let u = BeaconSet.beacon[index].key
            let value = BeaconSet.beacon[index].value
            let lat = value.getCoordLat()!
            let long = value.getCoordLon()!
            let loc:CLLocation = CLLocation.init(latitude: lat, longitude: long)
            //print(UUIDs)
            print(distanceOrder.count)
            print(distanceOrder.capacity)
            let dis = userLocation.distance(from: loc)
            let item:(String,Double)=(u,dis)
            distanceOrder.append(item)
            print("screw you")
            print(distanceOrder)
            print(item)
            print(distanceOrder.count)
            
            count += 1
        }
        
//        for n in distanceOrder.indices{
            for i in distanceOrder.indices {
                print("why can't code just work?!")
                print(distanceOrder)
                
                if (distanceOrder.index(after: i) == distanceOrder.count) {
                    break
                }
                
                print(distanceOrder[i])
                let next = distanceOrder.index(after: i)
                print(i)
                print(distanceOrder.index(after: i))
                print(distanceOrder[next])
        
                if(distanceOrder[i].value > distanceOrder[next].value){
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
        
        // }
        for x in distanceOrder.indices{
            print(distanceOrder[x].value)
        }
        
    BeaconSet.setDistanceOrder(dO: distanceOrder)

    }
    
    @objc func cancelScan() {
        centralManager1?.stopScan()
        print("Scan Stopped")
        print("Number of Peripherals Found: \(peripherals.count)")
    }
    
    func startScan() {
        print("Now Scanning...")
        self.timer.invalidate()
        centralManager1?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
        blePeripheral?.discoverServices(nil)
       
        print("what if thiS worked?!")
        print(centralManager1.isScanning)
        print(centralManager1.state)
        
        Timer.scheduledTimer(timeInterval: 17000, target: self, selector: #selector(self.cancelScan), userInfo: nil, repeats: false)
        
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectToDevice()
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        blePeripheral = peripheral
        
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        peripheral.delegate = self
        print("cool cool")
        print(peripheral.name as Any)
        
        
        if (((peripheral.name?.localizedCaseInsensitiveContains("Adafruit")) ?? false)){
            print(peripheral.name as Any)
            centralManager1.connect(peripheral, options: nil)
            print("new beacon, who dis?")
           // print(peripheral.readRSSI())
            navTo = peripheral
            beaconLoc = peripheral
            cancelScan()
            moveScreens()
        }
        
        if blePeripheral == nil {
            print("Found new pheripheral devices with services")
            print("Peripheral name: \(String(describing: peripheral.name))")
            print("**********************************")
            print ("Advertisement Data : \(advertisementData)")
        }
    }
    
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
            print(val?.getName() as Any)
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
        if(segue.identifier == "TransitDirections" && navTo == nil){
            

            let VC = segue.destination as! TransitNavigation
            VC.buttonIndex = clicked
            print("clicked")
            print(clicked)
            print(VC.buttonIndex)
        }
        
        if(segue.identifier == "FinalArrival"){
            print("hey so what isn't working?!")
            print("yo what if this janky way worked?")
            let ArrNav = storyboard!.instantiateViewController(withIdentifier: "ArrivalConfirmation") as! ArrivalConfirmation
            self.present(ArrNav, animated: true, completion: nil)
            centralManager1.stopScan()
            centralManager1.cancelPeripheralConnection(blePeripheral!)
            
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}


