//
//  AlertViewUtility.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

func showAlert(title: String?, message: String?, button: String?, controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: button, style: .default, handler: nil))
    controller.present(alert, animated: true, completion: nil)
}
