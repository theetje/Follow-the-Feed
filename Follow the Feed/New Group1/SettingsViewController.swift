//
//  SettingsViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 15-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        // maak een object om local user in op te slaan.
        let localUser = User(email: "", password: "")
        // Sla op in de UserDefaults van het apparaat.
        UserDefaults.standard.set(try? PropertyListEncoder().encode(localUser), forKey:"profile")
        
        self.performSegue(withIdentifier: "logOutsegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
