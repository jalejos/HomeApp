//
//  LoginViewController.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: SegueIdentifier.signIn.rawValue, sender: nil)
            }
        }
        localizeUI()
    }
    
    func localizeUI() {
        appLabel.text = "APP-NAME".localized()
        emailField.placeholder = "EMAIL".localized()
        passwordField.placeholder = "PASSWORD".localized()
        signinButton.setTitle("SIGN-IN".localized(), for: .normal)
        registerButton.setTitle("REGISTER".localized(), for: .normal)
    }
   
    @IBAction func registerTap(_ sender: Any) {
        FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                   password: passwordField.text!) { user, error in
                                    if error == nil {
                                        FIRAuth.auth()!.signIn(withEmail: self.emailField.text!,
                                                               password: self.passwordField.text!)
                                    } else {
                                        print(error)
                                    }
        }
    }
}
