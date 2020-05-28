//
//  PhoneKitEx.swift
//  LocationPicker
//
//  Created by Salah on 5/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation

extension Bundle{
    class var framwWorkBundle:Bundle?{
        let podBundle = Bundle(for: CountryViewController.self)
        if let bundleURL:URL = podBundle.url(forResource: "CountryListManager", withExtension: "bundle"){
        return Bundle(url: bundleURL)
        }
        return nil;
    }
}
