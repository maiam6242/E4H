//
//  ViewController.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/3/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
    @IBAction func goToMainPage(sender: Any) {
            print("click")
        //self.performSegue(withIdentifier: "LoadingToMain", sender: self)
    }
 */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("view loaded")
    }
    
    @IBAction func LoadingToMain(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "LoadingToMain", sender: self)
    }
    
}

