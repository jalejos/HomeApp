//
//  HouseRepository.swift
//  HomeApp
//
//  Created by Alejos on 5/22/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct HouseRepository {
    
    static let houseRef = FIRDatabase.database().reference(withPath: "houses")
    
    static func addHouse(dict: [String: Any], errorHandler: @escaping (Error?) -> ()) {
        houseRef.child(dict["address"] as! String).setValue(dict)
    }
}
