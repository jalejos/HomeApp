//
//  Home.swift
//  HomeApp
//
//  Created by Alejos on 5/18/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import ObjectMapper

class House: Mappable {
    var houseType: Int?
    var address: String?
    var state: String?
    var city: String?
    var bedAmount: Int?
    var bathAmount: Int?
    var description: String?
    var price: Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        houseType       <- map["houseType"]
        address         <- map["address"]
        state           <- map["state"]
        city            <- map["city"]
        bedAmount       <- map["bedAmount"]
        bathAmount      <- map["bathAmount"]
        description     <- map["description"]
        price           <- map["price"]
    }
}
