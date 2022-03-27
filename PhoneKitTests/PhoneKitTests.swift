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
        validatePhoneNumberCase1();
        validatePhoneNumberCase2();
        validatePhoneNumberCase3();
        validatePhoneNumberCase4();
        validatePhoneNumberCase5();
        validatePhoneNumberCase6();
        validatePhoneNumberCase7();

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    /// func validatePhoneNumber(fullPhoneNumber:String?)
    func validatePhoneNumberCase1(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"+972597105861"), true);
    }
    func validatePhoneNumberCase2(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"00972597105861"), true);
    }
    func validatePhoneNumberCase3(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"972597105861"), true);
    }
    func validatePhoneNumberCase4(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"597105861"), false);
    }
    func validatePhoneNumberCase5(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"asdasds"), false);
    }
    func validatePhoneNumberCase6(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:""), false);
    }
    func validatePhoneNumberCase7(){
        XCTAssertEqual(CountryListManager.shared.validatePhoneNumber(fullPhoneNumber:"105861"), false);
    }
    /// func validatePhoneNumber(countryCode:CountryCode?,phoneNumber:String?)
    
}
