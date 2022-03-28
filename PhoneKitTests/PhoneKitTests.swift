//
//  PhoneKitTests.swift
//  PhoneKitTests
//
//  Created by Salah on 3/27/22.
//  Copyright © 2022 Salah. All rights reserved.
//

import XCTest
import PhoneKit

class PhoneKitTests: XCTestCase {
    let countryObject = CountryListManager.shared.countryCode("PS")
    let phoneNumber = "597105861"
    let errorPhoneNumber = "597105860"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        validatePhoneNumber();
        validatePhoneNumberCountryCode();
        printPhoneNumber();
        isPhoneNumberEqualForStrings();
        countryCode();
        phoneNumberExport();
        currentCountryCode();
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    /// func validatePhoneNumber(fullPhoneNumber:String?)
    func validatePhoneNumber(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"+972597105861"), true);
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"00972597105861"), true);
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"972597105861"), true);
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"597105861"), false);
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"asdasds"), false);
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:""), false);
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"105861"), false);
    }
    /// func validatePhoneNumber(countryCode:CountryCode?,phoneNumber:String?)
    func validatePhoneNumberCountryCode(){
        let countryObject = CountryListManager.shared.countryCode("PS")
        // success
        let value1 = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"597105861");
        XCTAssertEqual(value1, true)
        // fail
        let value2 = CountryListManager.shared.validatePhoneNumber(countryCode: nil, phoneNumber:"597105861");
        XCTAssertEqual(value2, false)
        let value3 = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"");
        XCTAssertEqual(value3, false)
        let value4 = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"asdasd");
        XCTAssertEqual(value4, false)
        let value5 = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"123");
        XCTAssertEqual(value5, false)
    }
    /// public  func phoneNumber(phoneNumberType:PhoneNumberType,countryCode:CountryCode?,phoneNumber:String?)->String
    func printPhoneNumber(){
        // success
        let value1 = CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: phoneNumber) == "970\(phoneNumber)";
        XCTAssertEqual(value1, true)
        let value2 = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: phoneNumber) == "+970\(phoneNumber)";
        XCTAssertEqual(value2, true)
        let value3 = CountryListManager.shared.phoneNumber(phoneNumberType: .zerozero, countryCode: countryObject, phoneNumber: phoneNumber) == "00970\(phoneNumber)";
        XCTAssertEqual(value3, true)
        
        // fail
        let object1 = CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: nil)
        XCTAssertNil(object1)
        let object2 = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: nil, phoneNumber: phoneNumber)
        XCTAssertNil(object2)
        let object3 = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: nil, phoneNumber: nil)
        XCTAssertNil(object3)
        let object4 = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: "asdsad")
        XCTAssertNil(object4)
        let object5 = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: "123")
        XCTAssertNil(object5)
        let object6 = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: "123123211232132")
        XCTAssertNil(object6)
    }
    ///    func isPhoneNumberEqual(firstFullPhoneNumber:String,secondFullPhoneNumber:String)->Bool{
    func isPhoneNumberEqualForStrings(){
        // success
        let value1 = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"+970\(self.phoneNumber)", secondFullPhoneNumber:"970\(self.phoneNumber)");
        XCTAssertEqual(value1, true)
        let value2 = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"00970\(self.phoneNumber)", secondFullPhoneNumber:"970\(self.phoneNumber)");
        XCTAssertEqual(value2, true)
        let value3 = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"00970\(self.phoneNumber)", secondFullPhoneNumber:"+970\(self.phoneNumber)");
        XCTAssertEqual(value3, true)
        // fail
        let value4 = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"00970\(self.errorPhoneNumber)", secondFullPhoneNumber:"+970\(self.phoneNumber)");
        XCTAssertEqual(value4, false)
        let value5 = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"1", secondFullPhoneNumber:"1");
        XCTAssertEqual(value5, false)
    }
    ///    func countryCode(_ value:String?)->CountryCode?
    func countryCode(){
        XCTAssertNotNil(CountryListManager.shared.countryCode("970"))
        XCTAssertNotNil(CountryListManager.shared.countryCode("+970"))
        XCTAssertNotNil(CountryListManager.shared.countryCode("00970"))
    }
    ///   func isPhoneNumberEqual(countryCode:CountryCode?,phoneNumber:String?,fullPhoneNumber:String)->Bool
    func isPhoneNumberEqual(){
        var countryCode = CountryListManager.shared.countryCode("970");
        // success
        let value1 = CountryListManager.shared.isPhoneNumberEqual(countryCode: countryCode, phoneNumber:self.phoneNumber, fullPhoneNumber:"00970\(self.phoneNumber)");
        XCTAssertEqual(value1, true)
        
       // fail
        let value2 = CountryListManager.shared.isPhoneNumberEqual(countryCode: countryCode, phoneNumber:self.phoneNumber, fullPhoneNumber:"+970\(self.errorPhoneNumber)");
        XCTAssertEqual(value2, false)
        
        let value3 = CountryListManager.shared.isPhoneNumberEqual(countryCode: countryCode, phoneNumber:self.phoneNumber, fullPhoneNumber:"+970");
        XCTAssertEqual(value3, false)
        
        let value4 = CountryListManager.shared.isPhoneNumberEqual(countryCode: countryCode, phoneNumber:self.phoneNumber, fullPhoneNumber:"+97059");
        XCTAssertEqual(value4, false)

    }
    // func phoneNumber(fullPhoneNumber:String?)->(CountryCode?,String?)
    func phoneNumberExport(){
        // success
        let object1 = CountryListManager.shared.phoneNumber(fullPhoneNumber:"00970\(self.phoneNumber)")
        XCTAssertNotNil(object1.0)
        XCTAssertNotNil(object1.1)
        let object2 = CountryListManager.shared.phoneNumber(fullPhoneNumber:"+970\(self.phoneNumber)")
        XCTAssertNotNil(object2.0)
        XCTAssertNotNil(object2.1)
        let object3 = CountryListManager.shared.phoneNumber(fullPhoneNumber:"970\(self.phoneNumber)")
        XCTAssertNotNil(object3.0)
        XCTAssertNotNil(object3.1)
        let object4 = CountryListManager.shared.phoneNumber(fullPhoneNumber:"970\(self.errorPhoneNumber)")
        XCTAssertNotNil(object4.0)
        XCTAssertNotNil(object4.1)
        // fail
        let object5 = CountryListManager.shared.phoneNumber(fullPhoneNumber:"97059710")
        XCTAssertNil(object5.0)
        XCTAssertNil(object5.1)
        let object6 = CountryListManager.shared.phoneNumber(fullPhoneNumber:"970597k0")
        XCTAssertNil(object6.0)
        XCTAssertNil(object6.1)
    }
    func currentCountryCode(){
        XCTAssertNotNil(CountryListManager.shared.currentCountry)
    }
}
