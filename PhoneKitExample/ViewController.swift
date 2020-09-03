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
    @IBOutlet weak var stackViewFlagData: UIStackView!
    @IBOutlet weak var stackViewFlagData2: UIStackView!
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryName2: UILabel!

    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountryCode2: UILabel!

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var imgFlag2: UIImageView!

    @IBOutlet weak var txtPhoneNumber2: UITextField!
    var countryObject:CountryCode?{
        didSet{
            self.lblCountryCode.text = countryObject?.code;
            self.lblCountryName.text = countryObject?.localizeName();
            self.imgFlag.image = countryObject?.flag
        }
    }
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
    }

    @IBAction func btnPhoneNumberPicker(_ sender: Any) {
        self.present(countryViewController!, animated: true, completion: nil);
    }
    
}

extension ViewController: UITextFieldDelegate {
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if self.txtPhoneNumber2 == textField {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= CountryListManager.maximumNumberOfPhoneNumbers
    }
    return true
}
}
