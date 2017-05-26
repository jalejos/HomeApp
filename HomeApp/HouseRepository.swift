//
//  HouseRepository.swift
//  HomeApp
//
//  Created by Alejos on 5/22/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

struct HouseRepository {
    
    static let houseRef = FIRDatabase.database().reference(withPath: "houses")
    static let imageRef = FIRStorage.storage().reference()
    
    static func addHouse(dict: [String: Any], image: UIImage, errorHandler: @escaping (Error?) -> ()) {
        houseRef.child(dict["address"] as! String).setValue(dict)
        imageRef.child(dict["address"] as! String).put(UIImagePNGRepresentation(image)!)
    }
}
