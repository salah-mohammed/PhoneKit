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
    @IBOutlet weak var btnPhoneNumberPicker: UIButton!
    @IBOutlet weak var lblPhoneNumber: UILabel!

    var countryViewController:CountryViewController?
    var countryObject:CountryCodes?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.countryViewController = CountryViewController.initPicker();
        self.countryViewController?.selectedHandler = { object in
        self.countryObject = object;
        }
        self.countryObject=CountryListManager.shared.countryCode("+966")
        self.present(countryViewController!, animated: true, completion: nil);
    }

    @IBAction func btnPhoneNumberPicker(_ sender: Any) {

    }
    
}

