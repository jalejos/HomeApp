//
//  SideMenuTableViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/10/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    enum menuOptions: String {
        case forSale = "FOR-SALE"
        case forRent = "FOR-RENT"
        case savedHomes = "SAVED-HOMES"
        case recent = "RECENTLY-VIEWED-HOMES"
        case yourHome = "YOUR-HOME"
        case settings = "SETTINGS"
    }
    
    let menuOptionsArray = [menuOptions.forSale,
                            menuOptions.forRent,
                            menuOptions.savedHomes,
                            menuOptions.recent,
                            menuOptions.yourHome,
                            menuOptions.settings]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuOptionsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = menuOptionsArray[indexPath.row].rawValue.localized()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (menuOptionsArray[indexPath.row]) {
        case .forSale :
            break
        case .forRent :
            break
        case .savedHomes:
            break
        case .recent:
            break
        case .yourHome:
            break
        case .settings:
            performSegue(withIdentifier: "SettingsSegue", sender: self)
            break
        }
    }

}
