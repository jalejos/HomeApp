//
//  HomeFormViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/17/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import MapKit

class HomeFormViewController: ActivityDisplayViewController {

    //MARK: - UI elements
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
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
    //MARK: - Private properties
    private var selectedHouse: House?
    private var mapAnnotation: MKPointAnnotation?
    private let regionRadius: CLLocationDistance = 1000
    private enum TypeHouses: Int {
        case rent
        case sale
    }
    
    //MARK: - Fileprivate properties
    fileprivate var currentTextField: UITextField?
    fileprivate var selectedImage: UIImage?
    fileprivate let inputViewOptions = [1, 2, 3, 4, 5, 6]
    
    
    //MARK: - Initialization function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
        focusMapView()
        let mapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        mapView.addGestureRecognizer(mapRecognizer)
        addPickerView(to: bedsField)
        addPickerView(to: bathsField)
        if let house = selectedHouse {
            fillForm(with: house)
        }
    }
    
    //MARK: - Public functions
    func configure(with house: House) {
        selectedHouse = house
        HouseService.getHouseImage(house: house) { image, error in
            if let image = image {
                self.setImage(image)
            }
        }
    }
    
    //MARK: - Private functions
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
        imageLabel.text = "ADD-HOME-IMAGE-LABEL".localized()
        imageButton.setTitle("ADD-HOME-IMAGE-BUTTON".localized(), for: .normal)
    }
    
    private func focusMapView() {
        if let geolocation = selectedHouse?.geolocation {
            let location = CLLocation.init(latitude: geolocation.latitude!, longitude: geolocation.longitude!)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius * 2.0, self.regionRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
            changeAnnotation(location: location.coordinate)
        } else {
            LocationService.sharedInstance.getLocation { location in
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius * 2.0, self.regionRadius * 2.0)
                self.mapView.setRegion(coordinateRegion, animated: true)
            }
        }
    }
    
    private func addPickerView(to textField: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
    }
    
    private func reverseGeolocate(coordinate: CLLocationCoordinate2D) {
        showActivityIndicator(message: "Calculating")
        LocationService.sharedInstance.reverseGeolocatePlacemark(coordinate: coordinate) { placemark in
            self.hideActivityIndicator()
            if let placemark = placemark {
                if let locationName = placemark.addressDictionary!["Name"] as? String {
                    self.addressField.text = locationName
                }
                
                if let city = placemark.addressDictionary!["City"] as? String {
                    self.cityField.text = city
                }
                
                if let state = placemark.addressDictionary!["State"] as? String {
                    self.stateField.text = state
                }
            }
        }
    }
    
    private func requestPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func requestCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func changeAnnotation(location: CLLocationCoordinate2D) {
        if let mapAnnotation = mapAnnotation {
            mapView.removeAnnotation(mapAnnotation)
        }
        let annotation = MKPointAnnotation.init()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapAnnotation = annotation
        reverseGeolocate(coordinate: annotation.coordinate)
    }
    
    private func fillForm(with house: House) {
        typeHouseSegmentedControl.selectedSegmentIndex = house.houseType
        addressField.text = house.address
        stateField.text = house.state
        cityField.text = house.city
        bedsField.text = String(house.bedAmount)
        bathsField.text = String(house.bathAmount)
        descriptionTextView.text = house.description
        priceField.text = String(house.price)
    }
    
    private func isFormValid() -> Bool {
        if let address = addressField.text, let state = stateField.text, let city = cityField.text,
            let _ = Int(bedsField.text!), let _ = Int(bathsField.text!), let description = descriptionTextView.text, let _ = Int(priceField.text!) {
            if !address.isEmpty && !state.isEmpty && !city.isEmpty && !description.isEmpty {
                return true
            }
        }
        return false
    }
    
    fileprivate func setImage(_ image: UIImage) {
        imageView.image = image
        selectedImage = image
    }
    
    //MARK: - Selector functions
    dynamic private func handleMapTap(sender: UITapGestureRecognizer) {
        let mapPoint = sender.location(in: mapView)
        let map2DCoordinate = mapView.convert(mapPoint, toCoordinateFrom: mapView)
        
        changeAnnotation(location: map2DCoordinate)
    }

    //MARK: - UI elements functions
    @IBAction func submitTap(_ sender: Any) {
        guard let annotation = mapAnnotation
            else {
                AlertViewUtility.showAlert(title: "ADD-HOUSE-ERROR-TITLE".localized(), message: "ADD-HOUSE-SELECT-ANNOTATION".localized(),
                                           button: "CLOSE".localized(), controller: self)
                return
        }
        
        guard let image = selectedImage
            else {
                AlertViewUtility.showAlert(title: "ADD-HOUSE-ERROR-TITLE".localized(), message: "ADD-HOUSE-SELECT-IMAGE".localized(),
                                           button: "CLOSE".localized(), controller: self)
                return
        }
        if isFormValid() {
            let typeHouse = typeHouseSegmentedControl.selectedSegmentIndex
            showActivityIndicator(message: "Adding house")
            let house = House(houseType: typeHouse, address: addressField.text!, state: stateField.text!, city: cityField.text!, bedAmount: Int(bedsField.text!)!,
                              bathAmount: Int(bedsField.text!)!, description: descriptionTextView.text, price: Int(priceField.text!)!,
                              geolocation: Geolocation(longitude: annotation.coordinate.longitude, latitude: annotation.coordinate.latitude), image: image)
            HouseService.add(house: house) { error in
                self.hideActivityIndicator()
                if let error = error {
                    AlertViewUtility.showAlert(title: "ADD-HOUSE-ERROR-TITLE".localized(), message: error.localizedDescription, button: "CLOSE".localized(), controller: self)
                } else {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            AlertViewUtility.showAlert(title: "ADD-HOUSE-ERROR-TITLE".localized(), message: "ADD-HOUSE-INCOMPLETE-SUBMIT".localized(),
                                       button: "CLOSE".localized(), controller: self)
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        AlertViewUtility.showAlertDialog(title: "SELECT-IMAGE-SOURCE-TITLE".localized(), message: "SELECT-IMAGE-SOURCE-MESSAGE".localized(),
           firstOption: "PHOTO-LIBRARY".localized(), firstHandler: { _ in
            self.requestPhoto()
        }, secondOption: "CAMERA".localized(), secondHandler: { _ in
            self.requestCamera()
        }, controller: self)
    }
}

//MARK: - UITextFieldDelegate functions
extension HomeFormViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == bedsField || textField == bathsField {
            return false
        }
        
        if textField == priceField && string.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil && string.characters.count > 0 {
            return false
        }
        
        return true
    }
}

//MARK: - UIPickerViewDataSource functions
extension HomeFormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.inputViewOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.inputViewOptions[row]);
    }
}

//MARK: - UIPickerViewDelegate functions
extension HomeFormViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentTextField?.text = String(inputViewOptions[row])
    }
}

//MARK: - UIImagePickerControllerDelegate functions
extension HomeFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        setImage(chosenImage)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
