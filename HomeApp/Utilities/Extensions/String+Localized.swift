//
//  LocalizedStrings.swift
//  HomeApp
//
//  Created by Alejos on 5/8/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
