//
//  LoginValidationUnitTest.swift
//  SwiftUIChatAppTests
//
//  Created by NeoSOFT on 10/10/23.
//

import XCTest
@testable import SwiftUIChatApp

final class LoginValidationUnitTest: XCTestCase {

    var validation: LoginValidator!
    
    override func setUp() {
        super.setUp()
        self.validation = LoginValidator()
    }
    
    override func tearDown() {
        super.tearDown()
        self.validation = nil
    }
    
    func testEmptyEmail(){
        let result = self.validation.validateUser(userEmail: "", password: "password")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userEmailBlank))
    }
    func testValidEmail(){
        let result = self.validation.validateUser(userEmail: "invalidEmail", password: "password")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.userEmailValid))
    }
    func testEmptyPassword(){
        let result = self.validation.validateUser(userEmail: "rp@mailinator.com", password: "")
        XCTAssertEqual(result, .failure(StringConstants.LoginSignUp.passwordBlank))
    }
    func testValidCredentials(){
        let result = self.validation.validateUser(userEmail: "rp@mailinator.com", password: "password")
        XCTAssertEqual(result, .success)
    }
}
