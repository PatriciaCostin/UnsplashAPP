//
//  AlphaNumericValidationTests.swift
//  UnsplashTests
//
//  Created by Patricia Costin on 07.11.2023.
//

import XCTest
@testable import Unsplash

final class AlphaNumericValidationTests: XCTestCase {
    // MARK: - Properties

    private var sut: AlphaNumericValidator!
    
    // MARK: - Test Setup
       
    override func setUp() {
        super.setUp()
        sut = AlphaNumericValidator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Testing functions
    
    func test_GivenPasswordWithLetters_WhenAlphaNumericValidating_ThenReturnFalse() {
        // GIVEN:
        let password = "Password"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenPasswordWithNumbers_WhenAlphaNumericValidating_ThenReturnFalse() {
        // GIVEN:
        let password = "1234567"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenPasswordWithLettersAndNumbers_WhenAlphaNumericValidating_ThenReturnTrue() {
        // GIVEN:
        let password = "123abc"
        
        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertTrue(result)
    }
}
