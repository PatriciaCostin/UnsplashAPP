//
//  UnsplashAPIUnitTests.swift
//  UnsplashTests
//
//  Created by Patricia Costin on 02.11.2023.
//

import XCTest
@testable import Unsplash

final class DefaultServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    private var sut: DefaultService!
    
    // MARK: - Test Setup
    override func setUp() {
        super.setUp()
        sut = DefaultService()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Testing Functions
    
    func test_GivenObject_WhenSavedAndRetrieved_ThenConfirmIfEqual() {
        
        // GIVEN:
        let user = User(username: "einstein", password: "emc2")
        
        // WHEN:
        sut.save(user)
        let retrievedUser: User? = sut.retrieve(type: User.self)
        
        // THEN:
        XCTAssertEqual(user, retrievedUser)
            
        }
    
    func test_GivenObject_WhenDeteledAndRetrieved_ThenReturnNil() {
        
        // GIVEN:
        let user = User(username: "tesla", password: "teslacoil")
        
        // WHEN:
        sut.save(user)
        sut.delete(user)
        let retrievedUser: User? = sut.retrieve(type: User.self)
        
        // THEN:
        XCTAssertNil(retrievedUser)
    }
}

private struct User: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    let username: String
    let password: String
}
