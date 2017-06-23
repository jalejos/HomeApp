//
//  Geolocation.swift
//  HomeApp
//
//  Created by Alejos on 5/30/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

class Geolocation: Mappable {
    
    var longitude: Double?
    var latitude: Double?
    
    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        longitude   <- map["longitude"]
        latitude    <- map["latitude"]
    }
}
