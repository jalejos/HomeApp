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
    static let imageRef = FIRStorage.storage().reference()
    
    
    static func getHouses(completionHandler: @escaping ([String: Any]?, Error?) -> ()) {
        houseRef.observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                completionHandler(dict, nil)
            } else {
                completionHandler(nil, nil)
            }
        }) { error in
            completionHandler(nil, error)
        }
    }
    
    static func getHouseImage(house: House, completionHandler: @escaping (Data?, Error?) -> ()) {
        let houseImageRef = imageRef.child(house.key)
        houseImageRef.data(withMaxSize: Int64.max) { data, error in
            completionHandler(data, error)
        }
    }
    
    static func addHouse(dict: [String: Any], image: UIImage, completionHandler: @escaping (Error?) -> ()) {
        guard let userID = FIRAuth.auth()?.currentUser?.uid else { return }
        let userHouseRef = houseRef.child(userID)
        let houseChild = userHouseRef.childByAutoId()
        var houseDict = dict
        houseDict["key"] = houseChild.key
        houseChild.setValue(houseDict)
        let imageTask = imageRef.child(houseChild.key).put(UIImagePNGRepresentation(image.resized(toWidth: 400)!)!)
        imageTask.observe(.success) { _ in
            completionHandler(nil)
            imageTask.cancel()
        }
        imageTask.observe(.failure) { snapshot in
            completionHandler(snapshot.error)
            imageTask.cancel()
        }
    }
    
    static func getMyHouses(completionHandler: @escaping ([String: [String: Any]]?, Error?) -> ()) {
        guard let userID = FIRAuth.auth()?.currentUser?.uid else { return }
        let userHouseRef = houseRef.child(userID)
        userHouseRef.observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: [String: Any]] {
                completionHandler(dict, nil)
            } else {
                completionHandler(nil, nil)
            }
        }) { error in
            completionHandler(nil, error)
        }
    }
}
