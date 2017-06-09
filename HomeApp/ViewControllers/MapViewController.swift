//
//  MapViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//
//  House icon extracted from: "https://icons8.com/icon/1291/House"
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
    @IBOutlet weak var detailsButton: UIButton!
    
    //MARK: - Private properties
    private var houseArray: [House] = []
    private var selectedHouse: House?
    private let regionRadius: CLLocationDistance = 1000
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        localizeUI()
        focusUserLocation()
        getCurrentHousesAnnotations()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.houseDetails.rawValue {
            let viewController = segue.destination as! HouseDetailsViewController
            viewController.configure(house: selectedHouse!)
        }
    }
    
    //MARK: - Private functions
    private func localizeUI() {
        menuButton.title = "MENU".localized()
        filterButton.title = "FILTER".localized()
        searchBar.placeholder = "MAP-SEARCH-PLACEHOLDER".localized()
    }
    
    private func focusUserLocation() {
        LocationService.sharedInstance.getLocation { currentLocation in
            self.focusNewLocation(location: currentLocation)
        }
    }
    
    private func focusNewLocation(location: CLLocation) {
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
            } else if let error = error {
                AlertViewUtility.showAlert(title: "HOUSES-GET-ERROR".localized(), message: error.localizedDescription, button: "CANCEL".localized(), controller: self)
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
        let filteredHouses = houseArray.filter { house -> Bool in
            house.address == address
        }
        let house = filteredHouses[0]
        detailsAddressLabel.text = house.address
        detailsDescriptionTextView.text = house.description
        if let price = house.price, let baths = house.bathAmount, let beds = house.bedAmount {
            detailsPriceLabel.text = String(describing: price)
            detailsBathLabel.text = "#\(baths) baths"
            detailsBedLabel.text = "#\(beds) beds"
        }
        HouseService.getHouseImage(house: house) { image, error in
            if image != nil {
                self.detailsImageView.image = image
                self.selectedHouse?.image = image
            } else {
                let image = UIImage.init(named: "house-icon")
                self.detailsImageView.image = image
                self.selectedHouse?.image = image
            }
        }
        selectedHouse = house
    }
    
    //MARK: - UI functions
    @IBAction func detailsTap(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.houseDetails.rawValue, sender: self)
    }
}

//MARK: - Map view delegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "housePin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            let colorPointAnnotation = annotation as! HomeAppAnnotation
            pinView?.pinTintColor = colorPointAnnotation.pinColor
            
        } else {
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
