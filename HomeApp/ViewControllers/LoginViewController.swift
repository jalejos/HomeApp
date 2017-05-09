//
//  LoginViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//
//  Facebook login icon extracted from "https://icons8.com/web-app/13912/Facebook"
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    
    //MARK: - Initialization function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: SegueIdentifier.signIn.rawValue, sender: nil)
            }
        }
        localizeUI()
    }
    
    //MARK: - Private functions
    private func localizeUI() {
        appLabel.text = "APP-NAME".localized()
        emailField.placeholder = "EMAIL".localized()
        passwordField.placeholder = "PASSWORD".localized()
        signinButton.setTitle("SIGN-IN".localized(), for: .normal)
        registerButton.setTitle("REGISTER".localized(), for: .normal)
        facebookLabel.text = "FACEBOOK-LOGIN-LABEL".localized()
        facebookButton.setTitle("FACEBOOK-LOGIN-BUTTON".localized(), for: .normal)
    }
   
    //MARK: - UI functions
    @IBAction func signInTap(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
            if let error = error {
                showAlert(title: "SIGN-IN-ERROR-TITLE".localized(), message: error.localizedDescription, button: "CLOSE".localized(), controller: self)
            }
        }
    }
    
    @IBAction func registerTap(_ sender: Any) {
        FIRAuth.auth()!.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            if error == nil {
                FIRAuth.auth()!.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!)
            } else {
                showAlert(title: "REGISTER-ERROR-TITLE".localized(), message: error?.localizedDescription, button: "CLOSE".localized(), controller: self)
            }
        }
    }
    
    @IBAction func facebookTap(_ sender: Any) {
    }
}
