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
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsAddressLabel: UILabel!
    @IBOutlet weak var detailsPriceLabel: UILabel!
    @IBOutlet weak var detailsBedLabel: UILabel!
    @IBOutlet weak var detailsBathLabel: UILabel!
    @IBOutlet weak var detailsDescriptionTextView: UITextView!
    @IBOutlet weak var detailsDisplayHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsHideHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsImageSize: NSLayoutConstraint!
    
    //MARK: - Private properties
    private var houseArray: [House] = []
    private let regionRadius: CLLocationDistance = 1000
    
    //MARK: - Initialization function
    override func viewDidLoad() {
        super.viewDidLoad()

        localizeUI()
        focusCurrentLocation()
        getCurrentHousesAnnotations()
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
    
    private func getCurrentHousesAnnotations() {
        HouseService.getHouses { houses, error in
            if let houses = houses {
                self.houseArray = houses
                for house in houses {
                    self.displayAnnotation(house)
                }
            }
        }
    }
    
    private func displayAnnotation(_ house: House) {
        let annotation = HomeAppAnnotation.init(house: house)
        guard let geolocation = house.geolocation else { return }
        annotation.coordinate = CLLocationCoordinate2D.init(latitude: geolocation.latitude!,
                                                            longitude: geolocation.longitude!)
        mapView.addAnnotation(annotation)
    }
    
    fileprivate func configureDetailsView(address: String) {
        var selectedHouse : House?
        var count = 0
        while selectedHouse == nil {
            if houseArray[count].address == address {
                selectedHouse = houseArray[count]
            }
            count += 1
        }
        detailsAddressLabel.text = selectedHouse?.address
        detailsDescriptionTextView.text = selectedHouse?.description
        if let price = selectedHouse?.price, let baths = selectedHouse?.bathAmount, let beds = selectedHouse?.bedAmount {
            detailsPriceLabel.text = String(describing: price)
            detailsBathLabel.text = "#\(baths) baths"
            detailsBedLabel.text = "#\(beds) beds"
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            let colorPointAnnotation = annotation as! HomeAppAnnotation
            pinView?.pinTintColor = colorPointAnnotation.pinColor
            pinView?.isEnabled = true
            
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        detailsDisplayHeightConstraint.isActive = true
        detailsImageSize.constant = detailsDisplayHeightConstraint.constant / 2
        detailsHideHeightConstraint.isActive = false
        guard let address = view.annotation?.title else { return }
        configureDetailsView(address: address!)
    }
}
