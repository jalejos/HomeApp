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
    var houseType: Int = 0
    var address: String = ""
    var state: String = ""
    var city: String = ""
    var bedAmount: Int = 0
    var bathAmount: Int = 0
    var description: String = ""
    var price: Int = 0
    var geolocation: Geolocation = Geolocation(longitude: 0, latitude: 0)
    var image: UIImage?
    var key: String = ""
    
    init(houseType: Int, address: String, state: String, city: String, bedAmount: Int, bathAmount: Int, description: String, price: Int,
         geolocation: Geolocation, image: UIImage) {
        self.houseType = houseType
        self.address = address
        self.state = state
        self.city = city
        self.bedAmount = bedAmount
        self.bathAmount = bathAmount
        self.description = description
        self.price = price
        self.geolocation = geolocation
        self.image = image
    }
    
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
        geolocation     <- map["location"]
        key             <- map["key"]
    }
    
    func toDictionary() -> [String: Any] {
        return ["houseType": houseType, "address": address, "state": state, "city": city, "bedAmount": bedAmount,
                  "bathAmount": bathAmount, "description": description, "price": price,
                  "location": ["latitude": geolocation.latitude, "longitude": geolocation.longitude]]
    }
}
