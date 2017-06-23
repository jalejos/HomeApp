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
        return _locationManager
    }()
    fileprivate let defaultLocation = CLLocation.init(latitude: 29.175, longitude: -111.3583)
    fileprivate var returnLocation: (CLLocation) -> () = {_ in}
    fileprivate var currentLocation: CLLocation?
    
    //MARK: - Functions
    //MARK: Public functions
    func getLocation(completion: @escaping (CLLocation) -> ()) {
        if let currentLocation = currentLocation {
            completion(currentLocation)
            return
        }
        returnLocation = completion
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                updateCurrentLocation(newLocation: defaultLocation)
                break
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
                break
            }
        } else {
            updateCurrentLocation(newLocation: defaultLocation)
        }
    }
    
    func reverseGeolocatePlacemark(coordinate: CLLocationCoordinate2D, completionHandler: @escaping (CLPlacemark?) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placemark: CLPlacemark?
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    placemark = placemarks[0]
                }
            }
            completionHandler(placemark)
        })

    }
    
    //MARK: Private functions
    fileprivate func updateCurrentLocation(newLocation: CLLocation) {
        currentLocation = newLocation
        returnLocation(currentLocation!)
    }
}


//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateCurrentLocation(newLocation: locations.last!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateCurrentLocation(newLocation: defaultLocation)
    }
}
