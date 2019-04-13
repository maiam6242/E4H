//
//  BeaconData.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/10/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation

class beaconData {
    
    var name:String?
    var coordLat:Double?
    var coordLon:Double?
    
    
init(n:String,c:Double,f:Double){
        self.name = n
        self.coordLon = c
        self.coordLat = f
        }

    func getName() -> String? {
        return name
    }
    
    func getCoordLat() -> Double? {
        return coordLat
    }
    
    func getCoordLon() -> Double? {
        return coordLon
    }
    
}
