//
//  AlertViewUtility.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

struct AlertViewUtility {
    static func showAlert(title: String?, message: String?, button: String?, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertDialog(title: String?, message: String?, firstOption: String?, firstHandler: @escaping (UIAlertAction) -> (), secondOption: String?, secondHandler: @escaping (UIAlertAction) -> (), controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstOption, style: .default, handler: firstHandler))
        alert.addAction(UIAlertAction(title: secondOption, style: .default, handler: secondHandler))
        controller.present(alert, animated: true, completion: nil)
    }
}
