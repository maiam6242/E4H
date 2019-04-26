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
            BeaconSet.beacon["488D15E5-8EAC-062F-72K5-B0D5EA08AF49"] = beaconData(n: "Kansas Street and Route 27 Bus Stop", c: -71.356469, f: 42.292805)
            BeaconSet.beacon["11B037E9-88CE-46D1-FABB-4D5CA2881B27"] = beaconData(n: "Natick Center Commuter Rail", c: -71.347075, f: 42.285806)
            BeaconSet.beacon["29F35B05-084A-4AF4-9F64-A92F411CEA41"] = beaconData(n: "Natick Common Bus Stop", c: -71.347132, f: 42.284214)
            BeaconSet.beacon["73EEB531-EBF8-4495-A9E0-1E5316D2E6CF"] = beaconData(n: "Moran Park/Downtown Bus Stop", c: -71.347826, f: 42.285716)
            BeaconSet.beacon["FA33023B-E968-43FB-8E79-A2B9E3CA01A9"] = beaconData(n: "Coolidge Gardens Bus Stop", c: -71.347077, f: 42.280864)
            BeaconSet.beacon["11B037E9-88CE-46D1-FABB-4D5CA2881B27"] = beaconData(n: "Senior Center Bus Stop", c: -71.337094, f: 42.287485)
            BeaconSet.beacon["488D15E5-8EAC-062F-72F5-B0D5EA08AF49"] = beaconData(n: "Joe's House", c: -71.353893, f: 42.282489)
            
        }
    
}
    
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    

