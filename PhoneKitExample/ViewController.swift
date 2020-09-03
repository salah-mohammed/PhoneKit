//
//  ViewController.swift
//  PhoneKitExample
//
//  Created by Salah on 10/28/19.
//  Copyright © 2019 Salah. All rights reserved.
//

import UIKit
import PhoneKit

extension UIViewController{
    public func bs_showMessageWithTitle(title:String,message:String?)
     {
         let alert = UIAlertController(title:title, message:message, preferredStyle:UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "تم", style:UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
}

class ViewController: UIViewController {
    @IBOutlet weak var btnPhoneNumberPicker: UIButton!

    var countryViewController:CountryViewController?
    @IBOutlet weak var stackViewFlagData: UIStackView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblPhoneNumberWithZero: UILabel!
    @IBOutlet weak var lblPhoneNumberWithpluse: UILabel!
    @IBOutlet weak var lblPhoneNumberWithout: UILabel!
    @IBOutlet weak var stackViewResult: UIStackView!
    @IBOutlet weak var lblPhoneNumberOnly: UILabel!
    @IBOutlet weak var lblCountryCodeInResult: UILabel!
    /////
    @IBOutlet weak var txtSecondPhoneNumber: UITextField!
    @IBOutlet weak var lblSecondPhoneNumberWithZero: UILabel!
    @IBOutlet weak var lblSecondPhoneNumberWithpluse: UILabel!
    @IBOutlet weak var lblSecondPhoneNumberWithout: UILabel!
    @IBOutlet weak var lblSecondPhoneNumberOnly: UILabel!
    @IBOutlet weak var lblSecondCountryCodeInResult: UILabel!
    @IBOutlet weak var lblSecondCountryName: UILabel!
    @IBOutlet weak var imgExportFlag: UIImageView!
    //

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
        self.countryObject=CountryListManager.shared.currentCountry // get current country code
        self.countryObject=CountryListManager.shared.countryCode("+966")

    }

    @IBAction func btnPhoneNumberPicker(_ sender: Any) {
        self.present(countryViewController!, animated: true, completion: nil);
    }
    @IBAction func btnIsEqual(_ sender: Any) {
        if let phoneNumberItem:(CountryCode?,String?) = CountryListManager.shared.phoneNumber(fullPhoneNumber:self.txtSecondPhoneNumber.text ?? ""){
            if  CountryListManager.shared.isPhoneNumberEqual(countryCode: phoneNumberItem.0, phoneNumber: phoneNumberItem.1, fullPhoneNumber:"+966597105861"){
                
            }else{
                
            }
        }
    }
    @IBAction func btnExport(_ sender: Any) {
        if let phoneNumberItem:(CountryCode?,String?) = CountryListManager.shared.phoneNumber(fullPhoneNumber:self.txtSecondPhoneNumber.text ?? ""){
        self.lblSecondPhoneNumberWithZero.text = CountryListManager.shared.phoneNumber(phoneNumberType: .zerozero, countryCode: countryObject, phoneNumber:phoneNumberItem.1)
        self.lblSecondPhoneNumberWithpluse.text = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber:phoneNumberItem.1);
        self.lblSecondPhoneNumberWithout.text = CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber:phoneNumberItem.1);
        self.lblSecondCountryCodeInResult.text = phoneNumberItem.0?.dial_code;
        self.lblSecondPhoneNumberOnly.text = phoneNumberItem.1
        self.lblSecondCountryName.text = phoneNumberItem.0?.localizeName();

        self.imgExportFlag.image = phoneNumberItem.0?.flag;

    }
    }
    @IBAction func btnLogin(_ sender: Any) {
    if CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text){
        self.lblPhoneNumberWithZero.text=CountryListManager.shared.phoneNumber(phoneNumberType: .zerozero, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);
        self.lblPhoneNumberWithpluse.text=CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);
        self.lblPhoneNumberWithout.text=CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);

        let a = CountryListManager.shared.phoneNumber(fullPhoneNumber:self.lblPhoneNumberWithout.text ?? "");
        self.lblCountryCodeInResult.text = a.0?.dial_code;
        self.lblPhoneNumberOnly.text = a.1
    }else{
        self.bs_showMessageWithTitle(title:"خطأ", message:"رقم الهاتف غير صحيح");

    }
    }
}

extension ViewController: UITextFieldDelegate {
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if self.txtPhoneNumber == textField || self.txtSecondPhoneNumber == textField{
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
