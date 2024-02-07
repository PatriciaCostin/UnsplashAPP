//
//  PasswordValidationTests.swift
//  UnsplashTests
//
//  Created by Patricia Costin on 07.11.2023.
//

import XCTest
@testable import Unsplash

final class PasswordValidatorTests: XCTestCase {

    // MARK: - Properties

    private var sut: PasswordValidator!
    
    // MARK: - Test Setup
       
    override func setUp() {
        super.setUp()
        sut = PasswordValidator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Testing functions
    
    func test_GivenAlphaNumericPasswordLongerThan6Chars_WhenPasswordValidating_ThenReturnTrue() {
        // GIVEN:
        let password = "Password123"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertTrue(result)
    }
    
    func test_GivenAlphaNumericPasswordShorterThan6Chars_WhenPasswordValidating_ThenReturnFalse() {
        // GIVEN:
        let password = "old12"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenAlphaNumericPasswordLengh6Chars_WhenPasswordValidating_ThenReturnTrue() {
        // GIVEN:
        let password = "word12"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertTrue(result)
    }
    
    func test_GivenPasswordWithoutAlphaNumericChars_WhenPasswordValidating_ThenReturnFalse() {
        // GIVEN:
        let password = "!@#$%^&*()_+"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenEmptyPassword_WhenPasswordValidating_ThenReturnFalse() {
        // GIVEN:
        let password = ""
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertFalse(result)
    }
}
