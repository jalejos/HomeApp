//
//  HomeFormViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/17/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class HomeFormViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
    }
    
    private func localizeUI() {
        navigationItem.title = "ADD-HOME".localized()
        confirmButton.title = "SUBMIT".localized()
        selectLabel.text = "SELECT-LOCATION-LABEL".localized()
        typeHouseLabel.text = "TYPE-HOUSE-FORM-LABEL".localized()
        addressLabel.text = "ADDRESS".localized()
        addressField.placeholder = "ADDRESS".localized()
        stateLabel.text = "STATE".localized()
        stateField.text = "STATE".localized()
        cityLabel.text = "CITY".localized()
        cityField.text = "CITY".localized()
        bedsLabel.text = "BEDS-LABEL".localized()
        bathsLabel.text = "BATHS-LABEL".localized()
        descriptionLabel.text = "DESCRIPTION".localized()
        priceLabel.text = "PRICE".localized()
    }
}
