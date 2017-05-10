//
//  SettingsViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/10/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBAction func signOutTap(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        performSegue(withIdentifier: "signOut", sender: self)
    }
    
}
