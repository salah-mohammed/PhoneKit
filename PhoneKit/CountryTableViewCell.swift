//
//  CountryTableViewCell.swift
//  Concierge
//
//  Created by sondos on 1/20/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
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
        
    func countryName(country: String) -> String? {
        
        let current = Locale(identifier: "Arab")
        return current.localizedString(forRegionCode: country)
    }
    
    func configureCell(){
        if self.countryObj == nil {
            return
        }
        
        self.imgFlag.image = self.countryObj?.flag;
        self.lblDailCode.text = self.countryObj?.dial_code
        self.lblName.text = countryName(country: (self.countryObj?.code)!)

    }
}
