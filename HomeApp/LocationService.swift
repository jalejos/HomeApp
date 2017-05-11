//
//  LocationService.swift
//  HomeApp
//
//  Created by Alejos on 5/10/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    //MARK: - Shared instance
    static var sharedInstance = LocationService()
    
    //MARK: - Properties
    //MARK: Private properties
    private lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    //MARK: Public properties
    var returnLocation: (CLLocation) -> () = {_ in}
    
    //MARK: - Public functions
    func getLocation(completion: @escaping (CLLocation) -> ()) {
        returnLocation = completion
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                returnLocation(CLLocation.init(latitude: 29.175, longitude: -111.3583))
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            }
        } else {
            returnLocation(CLLocation.init(latitude: 29.175, longitude: -111.3583))
        }
    }
}


//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        returnLocation(locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        returnLocation(CLLocation.init(latitude: 29.175, longitude: -111.3583))
    }
}
