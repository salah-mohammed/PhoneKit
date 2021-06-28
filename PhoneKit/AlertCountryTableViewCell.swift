//
//  AlertCountryTableViewCell.swift
//  PhoneKit
//
//  Created by Salah on 6/28/21.
//  Copyright © 2021 Salah. All rights reserved.
//

import UIKit

class AlertCountryTableViewCell:UITableViewCell {
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblDailCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var countryObj : CountryCode?
    
    func configureCell(){
        if self.countryObj == nil {
            return
        }
        
        self.imgFlag.image = self.countryObj?.flag;
        self.lblDailCode.text = self.countryObj?.dial_code
        self.lblName.text = self.countryObj?.localizeName()

    }
}
