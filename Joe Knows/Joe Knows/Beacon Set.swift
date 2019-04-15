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
    
    
    static func beaconSet(ID : [String]) -> Dictionary<String,beaconData>{
        print(ID.count)
        fillMap(ID: ID)
        return beacon
    }
        
        
    static func fillMap(ID : [String]){
            BeaconSet.beacon[ID[0]] = beaconData(n: "TestName1", c: 30, f: 3)
            BeaconSet.beacon[ID[1]] = beaconData(n: "TestName2", c: 5, f: 6)
            BeaconSet.beacon[ID[2]] = beaconData(n: "TestName3", c: 4, f: 5)
            BeaconSet.beacon[ID[3]] = beaconData(n: "TestName4", c: 7, f: 2)
            BeaconSet.beacon[ID[4]] = beaconData(n: "TestName5", c: 1, f: 3)
            BeaconSet.beacon[ID[5]] = beaconData(n: "TestName6", c: 20, f: 2)
            BeaconSet.beacon[ID[6]] = beaconData(n: "TestName7", c: 81, f: 3)
            
        }
    
}
    
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    

