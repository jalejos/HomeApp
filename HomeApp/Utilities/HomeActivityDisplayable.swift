//
//  HomeActivityDisplayer.swift
//  HomeApp
//
//  Created by Alejos on 6/19/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

protocol HomeActivityDisplayable {
    func showActivityIndicator(message: String)
    func hideActivityIndicator()
}
