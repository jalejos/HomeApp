//
//  ActivityDisplayViewController.swift
//  HomeApp
//
//  Created by Alejos on 6/19/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class ActivityDisplayViewController: UIViewController {
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let activityEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
}

extension ActivityDisplayViewController: HomeActivityDisplayable {
    func showActivityIndicator(message: String) {
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = message
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        activityEffectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        activityEffectView.layer.cornerRadius = 15
        activityEffectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        activityEffectView.addSubview(activityIndicator)
        activityEffectView.addSubview(strLabel)
        view.addSubview(activityEffectView)
    }
    
    func hideActivityIndicator() {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        activityEffectView.removeFromSuperview()
    }
}
