//
//  Beacon Set.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/10/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation

class BeaconSet: beaconData{
    func beaconSet(name : String){
        
    var beacon:Dictionary<String,beaconData>

        func fillMap(){
            beacon["UUID1"] = beaconData(n:"TestName", c:1, f:3)
            beacon["UUID2"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID3"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID4"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID5"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID6"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID7"] = beaconData(n: "TestName", c: 1, f: 3)
            
        }
    }
    
}
