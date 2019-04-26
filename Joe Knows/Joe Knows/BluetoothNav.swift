//
//  BluetoothNav.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/22/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation
import CoreBluetooth

struct CentralManager{
    var cManager: CBCentralManager!
   
    mutating func initialize(){
        cManager = CBCentralManager(delegate: nil, queue: nil)}
}
