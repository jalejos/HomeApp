//
//  YourHomesViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/17/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class YourHomesViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
    }
    
    private func localizeUI() {
        navigationItem.title = "YOUR-HOME".localized()
        addButton.title = "ADD-HOME".localized()
    }
}
