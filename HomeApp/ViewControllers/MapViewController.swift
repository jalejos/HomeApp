//
//  MapViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import FirebaseAuth

class MapViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localizeUI()
    }
    
    func localizeUI() {
        menuButton.title = "MENU".localized()
        filterButton.title = "FILTER".localized()
        searchBar.placeholder = "MAP-SEARCH-PLACEHOLDER".localized()
    }
    
    @IBAction func signOutTap(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
    }
}
