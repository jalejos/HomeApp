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
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
    }
    
    func localizeUI() {
        navigationItem.title = "SETTINGS".localized()
        backButton.title = "BACK".localized()
        signOutButton.title = "SIGN-OUT".localized()
    }
    
    @IBAction func signOutTap(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        performSegue(withIdentifier: "signOut", sender: self)
    }
    
}
