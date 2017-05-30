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
    
    fileprivate var houseArray: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
        HouseService.getMyHouses { houses, error in
            if let houses = houses {
                self.houseArray = houses
                self.tableView.reloadData()
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
        let cell = UITableViewCell()
        cell.textLabel?.text = houseArray[indexPath.row].address
        return cell
    }
}

extension YourHomesViewController: UITableViewDelegate {
    
}
