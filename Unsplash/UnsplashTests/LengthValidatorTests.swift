//
//  LengthValidationTests.swift
//  UnsplashTests
//
//  Created by Patricia Costin on 07.11.2023.
//

import XCTest
@testable import Unsplash

final class LengthValidatorTests: XCTestCase {
    
    // MARK: - Properties

    private var sut: LengthValidator!
    
    // MARK: - Test Setup
       
    override func setUp() {
        super.setUp()
        sut = LengthValidator(minLength: 6)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Testing functions
    
    func test_GivenPasswordShorterThan6Chars_WhenLengthValidating_ThenReturnFalse() {
        // GIVEN:
        let password = "word"

        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertFalse(result)
    }
    
    func test_GivenPasswordWith6Chars_WhenLengthValidating_ThenReturnTrue() {
        // GIVEN:
        let password = "Word12"

        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertTrue(result)
    }
    
    func test_GivenPasswordLongerThan6Chars_WhenLengthValidating_ThenReturnTrue() {
        // GIVEN:
        let password = "Password"

        // WHEN:
        let result = sut.validate(value: password)
        
        // THEN:
        XCTAssertTrue(result)
    }
}
