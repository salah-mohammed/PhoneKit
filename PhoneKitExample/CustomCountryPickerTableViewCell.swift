//
//  CustomCountryPickerTableViewCell.swift
//  PhoneKitExample
//
//  Created by Salah on 9/4/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import PhoneKit
class CustomCountryPickerTableViewCell: UITableViewCell {
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblDailCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var countryObj : CountryCode?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(){
        if self.countryObj == nil {
            return
        }
        
        self.imgFlag.image = self.countryObj?.flag;
        self.lblDailCode.text = self.countryObj?.dial_code
        self.lblName.text = self.countryObj?.localizeName()

    }
}
