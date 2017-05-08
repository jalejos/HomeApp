//
//  LoginViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeUI()
    }
    
    func localizeUI() {
        appLabel.text = "APP-NAME".localized()
        emailField.placeholder = "EMAIL".localized()
        passwordField.placeholder = "PASSWORD".localized()
        signinButton.setTitle("SIGN-IN".localized(), for: .normal)
        registerButton.setTitle("REGISTER".localized(), for: .normal)
    }
   
}
