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
//        validatePhoneNumber();
//        validatePhoneNumberCountryCode();
//        printPhoneNumber();
        isPhoneNumberEqualForStrings();
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
        var value = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"597105861");
        XCTAssertEqual(value, true)
        // fail
        value = CountryListManager.shared.validatePhoneNumber(countryCode: nil, phoneNumber:"597105861");
        XCTAssertEqual(value, false)
        value = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"");
        XCTAssertEqual(value, false)
        value = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"asdasd");
        XCTAssertEqual(value, false)
        value = CountryListManager.shared.validatePhoneNumber(countryCode: countryObject, phoneNumber:"123");
        XCTAssertEqual(value, false)
    }
    /// public  func phoneNumber(phoneNumberType:PhoneNumberType,countryCode:CountryCode?,phoneNumber:String?)->String
    func printPhoneNumber(){
        // success
        var value = CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: phoneNumber) == "970\(phoneNumber)";
        XCTAssertEqual(value, true)
        value = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: phoneNumber) == "+970\(phoneNumber)";
        XCTAssertEqual(value, true)
        value = CountryListManager.shared.phoneNumber(phoneNumberType: .zerozero, countryCode: countryObject, phoneNumber: phoneNumber) == "00970\(phoneNumber)";
        XCTAssertEqual(value, true)
        
        // fail
        var object = CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: nil)
        XCTAssertNil(object)
        object = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: nil, phoneNumber: phoneNumber)
        XCTAssertNil(object)
        object = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: nil, phoneNumber: nil)
        XCTAssertNil(object)
        object = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: "asdsad")
        XCTAssertNil(object)
        object = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: "123")
        XCTAssertNil(object)
        object = CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: "123123211232132")
        XCTAssertNil(object)
    }
    ///    func isPhoneNumberEqual(firstFullPhoneNumber:String,secondFullPhoneNumber:String)->Bool{
    func isPhoneNumberEqualForStrings(){
        // success
        var value = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"+970\(self.phoneNumber)", secondFullPhoneNumber:"970\(self.phoneNumber)");
        XCTAssertEqual(value, true)
        value = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"00970\(self.phoneNumber)", secondFullPhoneNumber:"970\(self.phoneNumber)");
        XCTAssertEqual(value, true)
        value = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"00970\(self.phoneNumber)", secondFullPhoneNumber:"+970\(self.phoneNumber)");
        XCTAssertEqual(value, true)
        value = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"00970\(self.errorPhoneNumber)", secondFullPhoneNumber:"+970\(self.phoneNumber)");
        XCTAssertEqual(value, false)
        value = CountryListManager.shared.isPhoneNumberEqual(firstFullPhoneNumber:"1", secondFullPhoneNumber:"1");
        XCTAssertEqual(value, false)
    }
}
