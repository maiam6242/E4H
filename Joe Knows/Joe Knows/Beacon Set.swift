//
//  Beacon Set.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/10/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation
import CoreLocation

struct BeaconSet{
    var ID:String = ""
    var uuid:UUID = UUID(uuidString: "NO UUID HERE")!
    static var beacon = Dictionary<String,beaconData>()
    static var distanceOrder = [(name: String, value :Double)]()
    
    
    static func beaconSet() -> Dictionary<String,beaconData>{
        //print(ID.count)
        fillMap()
        return beacon
    }
    
    static func setDistanceOrder(dO: [(name: String, value : Double)] ){
        distanceOrder = dO;
        print("hey this is a fucntion")
    }
    
       
    static func fillMap(){
        BeaconSet.beacon["Adafruit Bluefruit LE 3A6A"] = beaconData(n: "Kansas Street and Route 27 Bus Stop", a: "3A6A", c: -71.356469, f: 42.292805)
        BeaconSet.beacon["Adafruit Bluefruit LE 3A92"] = beaconData(n: "Natick Center Commuter Rail", a: "3A92", c: -71.347075, f: 42.285806)
        BeaconSet.beacon["Adafruit Bluefruit LE 321C"] = beaconData(n: "Natick Common Bus Stop", a: "321C", c: -71.347132, f: 42.284214)
        BeaconSet.beacon["Adafruit Bluefruit LE 84BA"] = beaconData(n: "Moran Park/Downtown Bus Stop", a: "84BA", c: -71.347826, f: 42.285716)
        BeaconSet.beacon["Adafruit Bluefruit LE 0703"] = beaconData(n: "Coolidge Gardens Bus Stop", a: "0703", c: -71.347077, f: 42.280864)
        BeaconSet.beacon["Adafruit Bluefruit LE 9851"] = beaconData(n: "Senior Center Bus Stop", a: "9851", c: -71.337094, f: 42.287485)
        BeaconSet.beacon["Adafruit Bluefruit LE 6E45"] = beaconData(n: "Joe's House", a: "6E45", c: -71.353893, f: 42.282489)
            
        }
    
}
    
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    

