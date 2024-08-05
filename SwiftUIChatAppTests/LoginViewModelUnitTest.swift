//
//  LoginViewModelUnitTest.swift
//  SwiftUIChatAppTests
//
//  Created by NeoSOFT on 05/08/24.
//

import XCTest
@testable import SwiftUIChatApp

final class LoginViewModelUnitTest: XCTestCase {

    var loginViewModel: LoginViewModel!
    var mockSessionManager: SessionManager?

    override func setUp() {
        super.setUp()
        self.loginViewModel = LoginViewModel(iSessionManager: self.mockSessionManager)
    }
    
    override func tearDown() {
        super.tearDown()
        self.loginViewModel = nil
    }
    
    func testValidLogin() {
        
        self.loginViewModel.email = "sp@mailinator.com"
        self.loginViewModel.password = "123456"
        
        //self.mockSessionManager?.loggedUser
        let expectation = self.expectation(description: "Logged In Successfull !!")
        //
        self.loginViewModel.login()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(self.loginViewModel.isLoggedIn)
            XCTAssertFalse(self.loginViewModel.isLoading)
            XCTAssertNil(self.loginViewModel.errorMessage)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
