//
//  ViewController.swift
//  PhoneKitExample
//
//  Created by Salah on 10/28/19.
//  Copyright © 2019 Salah. All rights reserved.
//

import UIKit
import PhoneKit
class ViewController: UIViewController {
    @IBOutlet weak var btnLocationPicker: UIButton!
    @IBOutlet weak var lblLocationPicker: UILabel!

    var countryViewController:CountryViewController?
    var countryObject:CountryCodes?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLocationPicker(_ sender: Any) {
        self.countryViewController = CountryViewController.initPicker();
        self.countryViewController?.selectedHandler = { object in
        self.countryObject = object;
        }
        self.countryObject=CountryListManager.shared.countryCode("+966")
    }
    
}

