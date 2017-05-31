//
//  HomeAppAnnotation.swift
//  HomeApp
//
//  Created by Alejos on 5/31/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import MapKit
import UIKit

class HomeAppAnnotation: MKPointAnnotation {
    var pinColor: UIColor
    
    init(house: House) {
        if house.houseType == 0 {
            self.pinColor = .blue
        } else {
            self.pinColor = .purple
        }
        super.init()
        self.title = house.address
        self.subtitle = String(describing: house.price)
    }
}
