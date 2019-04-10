//
//  Beacon Set.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/10/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation

class BeaconSet: beaconData{
    var beacon:NSHashTable<beaconData>
    override init(){
        beaconData.setLocation()
    }
    
}
