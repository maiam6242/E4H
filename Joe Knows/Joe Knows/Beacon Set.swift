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
    
    
    static func beaconSet(ID : [String]) -> Dictionary<String,beaconData>{
        print(ID.count)
        fillMap(ID: ID)
        return beacon
    }
    
    static func setDistanceOrder(dO: [(name: String, value : Double)] ){
        distanceOrder = dO;
        print("hey this is a fucntion")
    }
    
       
    static func fillMap(ID : [String]){
            BeaconSet.beacon[ID[0]] = beaconData(n: "Kansas Street and Route 27 Bus Stop", c: -71.356469, f: 42.292805)
            BeaconSet.beacon[ID[1]] = beaconData(n: "Natick Center Commuter Rail", c: -71.347075, f: 42.285806)
            BeaconSet.beacon[ID[2]] = beaconData(n: "Natick Common Bus Stop", c: -71.347132, f: 42.284214)
            BeaconSet.beacon[ID[3]] = beaconData(n: "Moran Park/Downtown Bus Stop", c: -71.347826, f: 42.285716)
            BeaconSet.beacon[ID[4]] = beaconData(n: "Coolidge Gardens Bus Stop", c: -71.347077, f: 42.280864)
            BeaconSet.beacon[ID[5]] = beaconData(n: "Senior Center Bus Stop", c: -71.337094, f: 42.287485)
            BeaconSet.beacon[ID[6]] = beaconData(n: "Leonard Morse Hospital Bus Stop", c: -71.334033, f: 42.281315)
            
        }
    
}
    
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    

