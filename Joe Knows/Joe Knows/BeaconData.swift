//
//  BeaconData.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/10/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation

//Setting up a class for setting up beacons
class beaconData {
    
    var name:String?
    var coordLat:Double?
    var coordLon:Double?
    var adafruitNum:String?
    
    
    
    init(n:String, a: String, c:Double,f:Double){
        self.name = n
        self.coordLon = c
        self.coordLat = f
        self.adafruitNum = a
        }

    func getName() -> String? {
        return name
    }
    
    func getNum() -> String? {
        return adafruitNum
    }
    
    func getCoordLat() -> Double? {
        return coordLat
    }
    
    func getCoordLon() -> Double? {
        return coordLon
    }
    
}
