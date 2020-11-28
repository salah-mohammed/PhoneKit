//
//  Country.swift
//  Concierge
//
//  Created by SalahMohammed on 1/20/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit

public class CountryCode: NSObject {

    public var name : String?
    public var dial_code : String?
    public var code : String?
    
    
    private var imagePath: String
    private var image: UIImage?

    
    init(name : String , dial_code : String , code: String){
        self.name = name
        self.dial_code = dial_code
        self.code = code
        imagePath = "CountryListManager.bundle/\(self.code ?? "0")"

    }
    open func localizeName() -> String? {
        
        let current = Locale(identifier: "Arab")
        return current.localizedString(forRegionCode:self.code ?? "")
    }
    open var flag: UIImage? {
        if image != nil {
            return image
        }
        let flagImg = UIImage(named: imagePath, in: FrameWorkConstants.frameWorkBundle, compatibleWith: nil)
        image = flagImg
        return image
    }
//    static func == (lhs: CountryCodes, rhs: CountryCodes) -> Bool {
//        return lhs.dial_code == rhs.dial_code
//       }
}


