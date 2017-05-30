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
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var houseArray: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
        HouseService.getMyHouses { houses, error in
            if let _ = houses {
                
            }
        }
    }
    
    private func localizeUI() {
        navigationItem.title = "YOUR-HOME".localized()
        addButton.title = "ADD-HOME".localized()
    }
}

extension YourHomesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension YourHomesViewController: UITableViewDelegate {
    
}
