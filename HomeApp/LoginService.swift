//
//  LoginService.swift
//  HomeApp
//
//  Created by Alejos on 5/9/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit

struct LoginService {
    //MARK: - Singleton
    static var sharedInstance = LoginService()
    
    //MARK: - Private variables
    private let noAccessTokenError = NSError.init(domain: "HomeApp", code: 409, userInfo: [NSLocalizedDescriptionKey :  NSLocalizedString("Access Error", value: "NO-ACCESS-TOKEN-ERROR".localized(), comment: "")])
    
    //MARK: - Public functions
    func activateListener(completion: @escaping () -> ()) {
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                completion()
            }
        }
    }
    
    func appSignIn(username: String, password: String, errorHandler: @escaping (Error?) -> ()) {
        FIRAuth.auth()!.signIn(withEmail: username, password: password) { (user, error) in
            if let error = error {
                errorHandler(error)
            }
        }
    }
    
    func appRegister(username: String, password: String, errorHandler: @escaping (Error?) -> ()) {
        FIRAuth.auth()!.createUser(withEmail: username, password: password) { user, error in
            if error == nil {
                FIRAuth.auth()!.signIn(withEmail: username, password: password)
            } else {
                errorHandler(error)
            }
        }
    }
    
    func facebookLogin(controller: UIViewController, errorHandler: @escaping (Error?) -> ()) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: controller) { (result, error) in
            if let error = error {
                errorHandler(error)
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                errorHandler(self.noAccessTokenError)
                return
            }
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    errorHandler(error)
                }
            })
        }
    }
    
}
