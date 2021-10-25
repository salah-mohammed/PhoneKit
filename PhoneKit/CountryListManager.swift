//
//  ParseJSON.swift
//  Concierge
//
//  Created by SalahMohammed on 1/22/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit
import Foundation
import CoreTelephony

public class CountryListManager: NSObject {
   public static let maximumNumberOfPhoneNumbers:Int=11;
    
   public enum PhoneNumberType {
        case pluse
        case zerozero
        case none

    }
    var info = CTTelephonyNetworkInfo()
    public var currentCountry:CountryCode?{
        if let currentCode:String = self.countryCodeFromSIMCard() ?? self.countryCodeFromCurrentLocale() {
            return self.countryCode(code:currentCode);
        }
        return nil
    }
    public static let shared: CountryListManager = { CountryListManager()} ()
    override init() {
        super.init()
    }
     public func getDataFromJSON()->[CountryCode]?{
        if let path = Bundle.module?.path(forResource: "CountryListManager.bundle/countryCodes", ofType: "json") {
                let data:Data? = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let data:Data=data{
                    do {
                    let jsonResult:NSArray? = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSArray
                var countries = [CountryCode]()
                for i in jsonResult ?? [] {
                    let obj = i as! [String : Any]
                    let name = obj["name"] as! String
                    let dial_code = obj["dial_code"] as! String
                    let code = obj["code"] as! String
                
                countries.append(CountryCode.init(name: name , dial_code: dial_code , code : code))
                }
                  return countries
                } catch {
                    return nil;
                }
                }else{
                    return nil;
                }
            }
        return nil

  }
 
    public  func validatePhoneNumber(countryCode:CountryCode?,phoneNumber:String?)->Bool{
        if countryCode == nil  || phoneNumber?.count ?? 0 < 7 {
            return false;
        }
        if ((countryCode?.dial_code ?? "") + (phoneNumber ?? "")).count >= 15 {
            return false;
        }
        return true;
    }
    public  func isPhoneNumberEqual(countryCode:CountryCode?,phoneNumber:String?,fullPhoneNumber:String)->Bool{
        var temp = CountryListManager.shared.phoneNumber(fullPhoneNumber:fullPhoneNumber)
        if countryCode?.dial_code == temp.0?.dial_code &&  phoneNumber == temp.1{
        return true;
        }
        return false;
    }
    public  func phoneNumber(phoneNumberType:PhoneNumberType,countryCode:CountryCode?,phoneNumber:String?)->String{
        var countryCodeString:String?
        switch phoneNumberType {
            case PhoneNumberType.pluse:
            countryCodeString = countryCode?.dial_code ?? "";
            break;
            case PhoneNumberType.zerozero:
            countryCodeString = countryCode?.dial_code?.bs_replace(target:"+", withString:"00") ?? "";
            break;
        case PhoneNumberType.none:
            countryCodeString = countryCode?.dial_code?.bs_replace(target:"+", withString:"") ?? "";
            break;
        }
        
        return  ((countryCodeString ?? "") + (phoneNumber ?? "")).bs_arNumberToEn();
    }
    public  func phoneNumber(fullPhoneNumber:String)->(CountryCode?,String?){
        var tempFullPhoneNumber:String=fullPhoneNumber;
        if tempFullPhoneNumber.hasPrefix("00"){
            tempFullPhoneNumber.removeFirst();
            tempFullPhoneNumber.removeFirst();
            tempFullPhoneNumber = "+\(tempFullPhoneNumber)"
        }else
        if tempFullPhoneNumber.hasPrefix("+"){
        
        }else{
            tempFullPhoneNumber = "+\(tempFullPhoneNumber)"
        }
        tempFullPhoneNumber=tempFullPhoneNumber.bs_arNumberToEn();
       
        let countryObject:CountryCode? = self.getDataFromJSON()?.filter({ (countryObject) -> Bool in return tempFullPhoneNumber.contains(countryObject.dial_code ?? "")}).first
            
        var phoneNumber = tempFullPhoneNumber.bs_replace(target:countryObject?.dial_code ?? "", withString:"")
        if phoneNumber.hasPrefix("+"){
            phoneNumber.removeFirst();
        }
        return (countryObject,phoneNumber);
    
}
    // for example:+966,00966,966
    // for example:AF,US,UK
    public  func countryCode(_ value:String?)->CountryCode?{
        if let value:String=value{
            if value.bs_containsLetters{
                return self.countryCode(code: value);
            }else{
                return self.countryCode(dialCode: value);
            }
        }
   
        return nil
    }
    // for example:+966,00966,966
    public  func countryCode(dialCode:String?)->CountryCode?{
        var tempCountryCode:String=dialCode ?? "";
        if tempCountryCode.hasPrefix("00"){
            tempCountryCode.removeFirst();
            tempCountryCode.removeFirst();
            tempCountryCode = "+\(tempCountryCode)"
        }else if !tempCountryCode.hasPrefix("+"){
            tempCountryCode = "+\(tempCountryCode)"
        }
        tempCountryCode=tempCountryCode.bs_arNumberToEn();
        let countryObject:CountryCode? = self.getDataFromJSON()?.filter({ (countryObject) -> Bool in return tempCountryCode.contains(countryObject.dial_code ?? "")}).first
        return countryObject;
    }
    // for example:AF,US,UK
    public  func countryCode(code:String?)->CountryCode?{
        if let code:String=code{
            let countryObject:CountryCode? = self.getDataFromJSON()?.filter({ (countryObject) -> Bool in return code.uppercased().contains(countryObject.code?.uppercased() ?? "")}).first
        return countryObject;
        }
        return nil
    }
    // cuurent country code
    private func checkSIMCardAvailable() -> Bool{
        let carrier = info.subscriberCellularProvider
        if carrier?.mobileNetworkCode == nil || (carrier?.mobileNetworkCode == "") {
            return false
        }
        return true
    }
    private func countryCodeFromSIMCard() -> String?{
        let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider
        let countryCode = carrier?.isoCountryCode
        return countryCode
    }
    private func countryCodeFromCurrentLocale() -> String?{
    let currentLocale = NSLocale.current as NSLocale
    let countryCode = currentLocale.object(forKey: .countryCode) as? String
        return countryCode;
    }
}
