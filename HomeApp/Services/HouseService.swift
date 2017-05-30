//
//  HouseService.swift
//  HomeApp
//
//  Created by Alejos on 5/19/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

struct HouseService {
    static func addHouse(typeHouse: Int, address: String, state: String, city: String, beds: Int, baths: Int, description: String, price: Int, annotation: MKPointAnnotation,
                         image: UIImage, errorHandler: @escaping (Error?) -> ()) {
        
        let houseDict: [String:Any] = ["houseType": typeHouse, "address": address, "state": state, "city": city, "bedAmount": beds,
                                       "bathAmount": baths, "description": description, "price": price,
                                       "location": ["latitude": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude]]
        HouseRepository.addHouse(dict: houseDict, image: image) { error in
            errorHandler(error)
        }
    }
    
    static func getMyHouses(completionHandler: @escaping ([House]?, Error?) -> ()) {
        HouseRepository.getMyHouses { responseDict, error in
           
            if let responseDict = responseDict {
                let responseArray = Array(responseDict.values)
                if let houses = Mapper<House>().mapArray(JSONArray: responseArray) {
                    completionHandler(houses, nil)
                } else {
                    //TODO
                }
            } else {
                //TODO
            }
        }
    }
}
