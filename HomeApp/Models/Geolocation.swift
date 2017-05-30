//
//  Geolocation.swift
//  HomeApp
//
//  Created by Alejos on 5/30/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import ObjectMapper

class Geolocation: Mappable {
    
    var longitude: Double?
    var latitude: Double?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        longitude   <- map["longitude"]
        latitude    <- map["latitude"]
    }
}
