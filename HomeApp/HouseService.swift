//
//  HouseService.swift
//  HomeApp
//
//  Created by Alejos on 5/19/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct HouseService {
    static func addHouse(typeHouse: Int, address: String, state: String, city: String, beds: Int, baths: Int, description: String, price: Int,
                         errorHandler: @escaping (Error?) -> ()) {
        
        let houseDict: [String:Any] = ["houseType": typeHouse, "address": address, "state": state, "city": city, "bedAmount": beds, "bathAmount": baths,
                                       "description": description, "price": price]
        HouseRepository.addHouse(dict: houseDict) { error in
            errorHandler(error)
        }
    }
}
