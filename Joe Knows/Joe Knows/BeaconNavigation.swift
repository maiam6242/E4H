//
//  BeaconNavigation.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit

class BeaconNavigation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BeaconNavBack(_ sender: Any) {
        performSegue(withIdentifier: "BeaconNavBack", sender: self)
    }
    
    @IBAction func SecretArrival(_ sender: Any) {
        performSegue(withIdentifier: "SecretArrival", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
