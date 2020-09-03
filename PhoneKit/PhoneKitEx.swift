//
//  PhoneKitEx.swift
//  LocationPicker
//
//  Created by Salah on 5/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation

extension Bundle{

}
extension String{
    var customLocalize_ : String {
        return NSLocalizedString(self, tableName: nil, bundle:Bundle(for: CountryViewController.self) ?? Bundle.main, value: "", comment: "")
    }
}
