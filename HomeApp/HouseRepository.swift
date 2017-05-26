//
//  HouseRepository.swift
//  HomeApp
//
//  Created by Alejos on 5/22/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

struct HouseRepository {
    static let houseRef = FIRDatabase.database().reference(withPath: "houses")
    static let imageRef = FIRStorage.storage().reference(withPath: "houses")
    
    static func addHouse(dict: [String: Any], image: UIImage, errorHandler: @escaping (Error?) -> ()) {
        guard let userID = FIRAuth.auth()?.currentUser?.uid else { return }
        let userHouseRef = houseRef.child(userID)
        let userImageRef = imageRef.child(userID)
        userHouseRef.child(dict["address"] as! String).setValue(dict)
        userImageRef.child(dict["address"] as! String).put(UIImagePNGRepresentation(image)!)
    }
}
