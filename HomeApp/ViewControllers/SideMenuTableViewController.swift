//
//  SideMenuTableViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/10/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    //MARK: - Properties
    enum MenuOptions: String {
        case forSale = "FOR-SALE"
        case forRent = "FOR-RENT"
        case savedHomes = "SAVED-HOMES"
        case recent = "RECENTLY-VIEWED-HOMES"
        case yourHome = "YOUR-HOME"
        case settings = "SETTINGS"
    }
    
    let menuOptionsArray: [MenuOptions] = [.forSale,
                            .forRent,
                            .savedHomes,
                            .recent,
                            .yourHome,
                            .settings]

    //MARK: - Initialization function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "APP-NAME".localized()
    }
    
    
    //MARK: - Private functions
    fileprivate func executeSegue(_ segue: String) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            if let navigation = topController as? UINavigationController {
                if let mapViewController = navigation.topViewController as? MapViewController {
                    mapViewController.performSegue(withIdentifier: segue, sender: mapViewController)
                }
            }
        }
    }
    
}

// MARK: - Table view data source
extension SideMenuTableViewController {
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
            dismiss(animated: true, completion: {
                self.executeSegue(SegueIdentifier.settings.rawValue)
            })
            break
        }
    }

}
