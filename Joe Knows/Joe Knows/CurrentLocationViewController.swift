//
//  CurrentLocationViewController.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/3/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit

class CurrentLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func MainToLoading(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "MainToLoading", sender: self)
    }
}
