//
//  HouseDetailsViewController.swift
//  HomeApp
//
//  Created by Alejos on 6/9/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class HouseDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate enum tableRowTypes: Int {
        case image
        case address
        case price
        case baths
        case beds
        case details
    }
    fileprivate let rowAmount = 6
    fileprivate let cellIdentifier = "cell"
    fileprivate var house: House?
    
    func configure(house: House) {
        self.house = house
        
    }

}

extension HouseDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        if let house = house {
            switch indexPath.row {
            case tableRowTypes.image.rawValue:
                cell?.imageView?.image = house.image
                break;
            case tableRowTypes.address.rawValue:
                cell?.textLabel?.text = house.address
                break;
            case tableRowTypes.price.rawValue:
                cell?.textLabel?.text = "$\(house.price!)"
                break;
            case tableRowTypes.baths.rawValue:
                cell?.textLabel?.text = "\(house.bathAmount!) baths"
                break;
            case tableRowTypes.beds.rawValue:
                cell?.textLabel?.text = "\(house.bedAmount!) beds"
                break;
            case tableRowTypes.details.rawValue:
                cell?.textLabel?.text = house.description
                break;
            default:
                break;
            }
        }
        return cell!
    }
}
