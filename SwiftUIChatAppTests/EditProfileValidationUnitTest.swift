//
//  EditProfileValidationUnitTest.swift
//  SwiftUIChatAppTests
//
//  Created by NeoSOFT on 05/08/24.
//

import XCTest
@testable import SwiftUIChatApp

final class EditProfileValidationUnitTest: XCTestCase {

    var validation : EditProfileValidator!
    
    override func setUp() {
        super.setUp()
        self.validation = EditProfileValidator()
    }
    
    override func tearDown() {
        super.tearDown()
        self.validation = nil
    }
    
    func testEmptyName(){
        let result = self.validation.validateUser(userName: "", userEmail: "", userCountryCode: "", userMobile: "", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userNameBlank))
    }
    func testEmptyEmail(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "", userCountryCode: "", userMobile: "", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userEmailBlank))
    }
    func testValidEmail(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "invalid", userCountryCode: "", userMobile: "", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userEmailValid))
    }
    func testEmptyCountryCode(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "", userMobile: "", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userCountryCodeBlank))
    }
    func testEmptyMobile(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userMobileBlank))
    }
    func testValidMobile(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "0987654321", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userMobileValid))
    }
    func testEmptyDOB(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userDOBBlank))
    }
    func testValidate(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "April 1, 1994")
        XCTAssertEqual(result, .success)
    }
}
