//
//  AddStopNew.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/7/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit

class AddStopNew: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddStopNewBack(_ sender: Any) {
        performSegue(withIdentifier: "AddStopNo", sender: self)
    }
    
    @IBAction func AddStopNewNo(_ sender: Any) {
        performSegue(withIdentifier: "AddStopNo", sender: self)
    }
    @IBAction func AddStopNewYes(_ sender: Any) {
        performSegue(withIdentifier: "YesAddStop", sender: self)
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
