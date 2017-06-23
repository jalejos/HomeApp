//
//  HomeImageTableViewCell.swift
//  HomeApp
//
//  Created by Alejos on 6/23/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class HomeImageTableViewCell: UITableViewCell {

    @IBOutlet weak var homePreview: UIImageView!
    
    func configureWith(_ image: UIImage?) {
        homePreview.image = image
    }
}
