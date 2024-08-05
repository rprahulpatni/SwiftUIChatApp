//
//  SignUpValidationUnitTest.swift
//  SwiftUIChatAppTests
//
//  Created by NeoSOFT on 05/08/24.
//

import XCTest
@testable import SwiftUIChatApp

final class SignUpValidationUnitTest: XCTestCase {

    var validation: SignUpValidator!
    
    override func setUp() {
        super.setUp()
        self.validation = SignUpValidator()
    }
    
    override func tearDown() {
        super.tearDown()
        self.validation = nil
    }
    
    func testEmptyName(){
        let result = self.validation.validateUser(userName: "", userEmail: "", userCountryCode: "", userMobile: "", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userNameBlank))
    }
    func testEmptyEmail(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "", userCountryCode: "", userMobile: "", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userEmailBlank))
    }
    func testValidEmail(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "invalid", userCountryCode: "", userMobile: "", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userEmailValid))
    }
    func testEmptyCountryCode(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "", userMobile: "", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userCountryCodeBlank))
    }
    func testEmptyMobile(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userMobileBlank))
    }
    func testValidMobile(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "123456", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userMobileValid))
    }
    func testEmptyDOB(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userDOBBlank))
    }
    func testEmptyPassword(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "April 1, 1994", password: "", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.passwordBlank))
    }
    func testEmptyConfirmPassword(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "April 1, 1994", password: "password", confirmPassword: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.confirmPasswordBlank))
    }
    func testPasswordConfirmMisMatch(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "April 1, 1994", password: "password", confirmPassword: "password12")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.confirmPasswordMatch))
    }
    func testPasswordConfirmMatch(){
        let result = self.validation.validateUser(userName: "R P", userEmail: "rp@mailinator.com", userCountryCode: "+91", userMobile: "9876543210", userDOB: "April 1, 1994", password: "password", confirmPassword: "password")
        XCTAssertEqual(result, .success)
    }
}

