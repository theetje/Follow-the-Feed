//
//  SettingsViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 15-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // ACTIONS:
    // Ga naar de loginpagina en maak de data die is opgeslagen "leeg".
    @IBAction func logOut(_ sender: Any) {
        let localUser = User(email: "", password: "")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(localUser), forKey:"profile")
        self.performSegue(withIdentifier: "logOutsegue", sender: self)
    }
    
    // OVERRIDES:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
