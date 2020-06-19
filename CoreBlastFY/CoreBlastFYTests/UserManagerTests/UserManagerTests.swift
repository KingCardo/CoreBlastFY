//
//  UserManagerTests.swift
//  CoreBlastFYTests
//
//  Created by Riccardo Washington on 6/18/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

@testable import CoreBlastFY
import XCTest

class UserManagerTests: XCTestCase {
    
    var sut: User!
    
    // MARK: Test lifecycle
    
    override func setUp() {
      super.setUp()
      setupUser()
    }
    
    override func tearDown() {
      super.tearDown()
      sut = nil
    }
    
    // MARK: Test setup
    
    func setupUser() {
        UserAPI.user = UserManager.loadUserFromFile()
        sut = UserAPI.user
    }

    func test_Increment_Point() {
        
    }
    
    func test_Decrement_Point() {
        
    }
    
    func test_Calculate_Level() {
        sut.totalPoints += 15
        
        UserManager.calculateLevel(totalPoints: sut.totalPoints)
        
        XCTAssertEqual(sut.coreLevel.rawValue, "Novice")
    }
}
