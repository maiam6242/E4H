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
    static var distanceOrder = [String:Double]()
    
    
    static func beaconSet(ID : [String]) -> Dictionary<String,beaconData>{
        print(ID.count)
        fillMap(ID: ID)
        return beacon
    }
    
    static func setDistanceOrder(dO: [String: Double] ){
        distanceOrder = dO;
        print("hey this is a fucntion")
    }
    
       
    static func fillMap(ID : [String]){
        BeaconSet.beacon[ID[0]] = beaconData(n: "TestName1", c: -71.383831798, f: 42.300332132
)
            BeaconSet.beacon[ID[1]] = beaconData(n: "TestName2", c: -71.383831798, f: 42.300332133)
            BeaconSet.beacon[ID[2]] = beaconData(n: "TestName3", c: -71.383831791, f: 42.300332134)
            BeaconSet.beacon[ID[3]] = beaconData(n: "TestName4", c: -71.383831793, f: 42.300332136)
            BeaconSet.beacon[ID[4]] = beaconData(n: "TestName5", c: -71.383831794, f: 42.300332132)
            BeaconSet.beacon[ID[5]] = beaconData(n: "TestName6", c: -71.383831799, f: 42.300332139)
            BeaconSet.beacon[ID[6]] = beaconData(n: "TestName7", c: -71.383831797, f: 42.300332130)
            
        }
    
}
    
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    

