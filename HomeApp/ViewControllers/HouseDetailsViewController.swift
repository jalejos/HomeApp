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
    fileprivate let imageCellIdentifier = "image"
    fileprivate let textCellIdentifier = "cell"
    fileprivate var house: House?
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "HomeImageTableViewCell", bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

    }
    
    func configure(house: House) {
        self.house = house
    }

}

extension HouseDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowAmount
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellText: String?
        var cellImage: UIImage?
        if let house = house {
            switch indexPath.row {
            case tableRowTypes.image.rawValue:
                cellImage = house.image
            case tableRowTypes.address.rawValue:
                cellText = house.address
                break;
            case tableRowTypes.price.rawValue:
                cellText = "$\(house.price)"
                break;
            case tableRowTypes.baths.rawValue:
                cellText = "\(house.bathAmount) baths"
                break;
            case tableRowTypes.beds.rawValue:
                cellText = "\(house.bedAmount) beds"
                break;
            case tableRowTypes.details.rawValue:
                cellText = house.description
                break;
            default:
                break;
            }
        }
        if indexPath.row == tableRowTypes.image.rawValue {
            var cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier) as? HomeImageTableViewCell
            if cell == nil {
                cell = HomeImageTableViewCell.init(style: .default, reuseIdentifier: imageCellIdentifier)
            }
            cell?.configureWith(cellImage)
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: textCellIdentifier)
            }
            cell?.textLabel?.text = cellText
            return cell!
        }
    }
    
}
