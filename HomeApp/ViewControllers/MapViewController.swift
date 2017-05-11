//
//  MapViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: - UI elements
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Private properties
    private let regionRadius: CLLocationDistance = 1000
    
    //MARK: - Initialization function
    override func viewDidLoad() {
        super.viewDidLoad()

        localizeUI()
        focusCurrentLocation()
    }
    
    //MARK: - Private functions
    private func localizeUI() {
        menuButton.title = "MENU".localized()
        filterButton.title = "FILTER".localized()
        searchBar.placeholder = "MAP-SEARCH-PLACEHOLDER".localized()
    }
    
    private func focusCurrentLocation() {
        LocationService.sharedInstance.getLocation { currentLocation in
            self.focusLocation(location: currentLocation)
        }
    }
    
    private func focusLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: - Unwind function
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
    }
}
