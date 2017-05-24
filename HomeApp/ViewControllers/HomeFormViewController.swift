//
//  HomeFormViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/17/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import MapKit

class HomeFormViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var typeHouseLabel: UILabel!
    @IBOutlet weak var typeHouseSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var bedsField: UITextField!
    @IBOutlet weak var bathsLabel: UILabel!
    @IBOutlet weak var bathsField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceField: UITextField!
    
    
    //MARK: - Private properties
    private let regionRadius: CLLocationDistance = 1000
    private var mapAnnotation: MKPointAnnotation?
    
    private enum TypeHouses: Int {
        case rent
        case sale
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
        focusMapView()
        addGestureRecognizer()
    }
    
    private func localizeUI() {
        navigationItem.title = "ADD-HOME".localized()
        confirmButton.title = "SUBMIT".localized()
        selectLabel.text = "SELECT-LOCATION-LABEL".localized()
        typeHouseLabel.text = "TYPE-HOUSE-FORM-LABEL".localized()
        typeHouseSegmentedControl.setTitle("RENT".localized(), forSegmentAt: TypeHouses.rent.rawValue)
        typeHouseSegmentedControl.setTitle("SALE".localized(), forSegmentAt: TypeHouses.sale.rawValue)
        addressLabel.text = "ADDRESS".localized()
        addressField.placeholder = "ADDRESS".localized()
        stateLabel.text = "STATE".localized()
        stateField.placeholder = "STATE".localized()
        cityLabel.text = "CITY".localized()
        cityField.placeholder = "CITY".localized()
        bedsLabel.text = "BEDS-LABEL".localized()
        bathsLabel.text = "BATHS-LABEL".localized()
        descriptionLabel.text = "DESCRIPTION".localized()
        priceLabel.text = "PRICE".localized()
    }
    
    private func focusMapView() {
        LocationService.sharedInstance.getLocation { location in
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius * 2.0, self.regionRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    private func addGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        mapView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleMapTap(sender: UITapGestureRecognizer? = nil) {
        let mapPoint = sender?.location(in: mapView)
        let map2DCoordinate = mapView.convert(mapPoint!, toCoordinateFrom: mapView)
        
        if let mapAnnotation = mapAnnotation {
            mapView.removeAnnotation(mapAnnotation)
        }
        let annotation = MKPointAnnotation.init()
        annotation.coordinate = map2DCoordinate
        mapView.addAnnotation(annotation)
        mapAnnotation = annotation
        reverseGeolocate(coordinate: annotation.coordinate)
    }
    
    private func reverseGeolocate(coordinate: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let locationName = placeMark.addressDictionary!["Name"] as? String {
                self.addressField.text = locationName
            }
            
            if let city = placeMark.addressDictionary!["City"] as? String {
                self.cityField.text = city
            }
            
            if let state = placeMark.addressDictionary!["State"] as? String {
                self.stateField.text = state
            }
        })
        
    }

    
    @IBAction func submitTap(_ sender: Any) {
        guard let typeHouse = Int(priceField.text!), let address = addressField.text, let state = stateField.text, let city = cityField.text,
            let beds = Int(bedsField.text!), let baths = Int(bathsField.text!), let description = descriptionTextView.text, let price = Int(priceField.text!),
            let annotation = mapAnnotation
            else {
                AlertViewUtility.showAlert(title: "ADD-HOUSE-ERROR-TITLE".localized(), message: "ADD-HOUSE-INCOMPLETE-SUBMIT".localized(),
                                           button: "CLOSE".localized(), controller: self)
                return
        }

        HouseService.addHouse(typeHouse: typeHouse, address: address, state: state, city: city, beds: beds, baths: baths,
                              description: description, price: price) { error in
            if let error = error {
                AlertViewUtility.showAlert(title: "ADD-HOUSE-ERROR-TITLE".localized(), message: error.localizedDescription, button: "CLOSE".localized(), controller: self)
            }
        }
    }
}
