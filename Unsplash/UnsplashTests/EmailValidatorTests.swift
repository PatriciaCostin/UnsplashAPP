//
//  EmailValidationTests.swift
//  UnsplashTests
//
//  Created by Patricia Costin on 07.11.2023.
//

import XCTest
@testable import Unsplash

final class EmailValidatorTests: XCTestCase {

    // MARK: - Properties

    private var sut: EmailValidator!
    
    // MARK: - Test Setup
       
    override func setUp() {
        super.setUp()
        sut = EmailValidator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Testing functions
    
    func test_GivenEmailWithMissingAtSymbol_WhenValidatingEmail_ThanReturnFalse() {
        // GIVEN:
        let email = "useremail.com"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenValidEmail_WhenValidatingEmail_ThanReturnTrue() {
        // GIVEN:
        let email = "user@email.com"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertTrue(result)
    }

    func test_GivenEmailWithMissingDot_WhenValidatingEmail_ThenReturnFalse() {
        // GIVEN:
        let email = "user@mailcom"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmailWithAllowedSpecialCharacters_WhenValidatingEmail_ThenReturnTrue() {
        // GIVEN:
        let email = "u_s%e-r+@mail.com"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertTrue(result)
    }
    
    func test_GivenEmailWithDisallowedSpecialCharacters_WhenValidatingEmail_ThenReturnFalse() {
        // GIVEN:
        let email = "u#s$&*e(r)@mail.com"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmailWithSubdomains_WhenValidatingEmail_ThenReturnTrue() {
        // GIVEN:
        let email = "user@sub.domain.com"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertTrue(result)
    }
    
    func test_GivenEmailWithLongerThan64CharsDomain_WhenValidationEmail_ThenReturnFalse() {
        // GIVEN:
        let email = "user@mail.cooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooom"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmailWithShorterThan2CharsDomain_WhenValidatingEmail_ThenReturnFalse() {
        // GIVEN:
        let email = "user@mail.c"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmailWith64CharsDomain_WhenValidationEmail_ThenReturnTrue() {
        // GIVEN:
        let email = "user@mail.coooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooom"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertTrue(result)
    }
    
    func test_GivenEmailWithAlphaNumericsInDomain_WhenValidationEmail_ThenReturnFalse() {
        // GIVEN:
        let email = "user@mail.her1"
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmailWithSpecialCharactersInDomain_WhenValidationEmail_ThenReturnFalse() {
        // GIVEN:
        let email = "user@mail.com!@#$%^&*()"

        // WHEN:
        let result = sut.validate(value: email)

        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmptyEmail_WhenValidatingEmail_ThanReturnFalse() {
        // GIVEN:
        let email = ""
        
        // WHEN:
        let result = sut.validate(value: email)
        
        // THEN:
        XCTAssertFalse(result)
    }
}
