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
        BeaconSet.beacon[ID[0]] = beaconData(n: "TestName1", c: -71.387, f: 42.302
)
            BeaconSet.beacon[ID[1]] = beaconData(n: "TestName2", c: -71.383, f: 42.36)
            BeaconSet.beacon[ID[2]] = beaconData(n: "TestName3", c: -71.39, f: 42.30)
            BeaconSet.beacon[ID[3]] = beaconData(n: "TestName4", c: -71.9, f: 42.4)
            BeaconSet.beacon[ID[4]] = beaconData(n: "TestName5", c: -71.383831, f: 42.300332)
            BeaconSet.beacon[ID[5]] = beaconData(n: "TestName6", c: -71.388, f: 42.30)
            BeaconSet.beacon[ID[6]] = beaconData(n: "TestName7", c: -71.567, f: 42.98)
            
        }
    
}
    
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    

