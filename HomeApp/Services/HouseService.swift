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
    
    //MARK: - Public functions
    static func getHouses(completionHandler: @escaping ([House]?, Error?) -> ()) {
        HouseRepository.getHouses { responseDict, error in
            if let responseDict = responseDict {
                let responseArray = Array(responseDict.values)
                var housesDictArray: [[String: Any]] = []
                for userHouseDict in responseArray {
                    let userHouseDict = userHouseDict as! [String: [String: Any]]
                    housesDictArray.append(contentsOf: Array(userHouseDict.values))
                }
                if let houses = Mapper<House>().mapArray(JSONArray: housesDictArray) {
                    completionHandler(houses, nil)
                }
            }
        }
    }
  
    static func getHouseImage(house: House, completionHandler: @escaping (UIImage?, Error?) -> ()) {
        HouseRepository.getHouseImage(house: house) { data, error in
            if let data = data {
                completionHandler(UIImage.init(data: data), error)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
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
                    completionHandler([], nil)
                }
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
