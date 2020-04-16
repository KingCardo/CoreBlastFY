//
//  PreWorkoutInteractorTests.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/16/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CoreBlastFY
import XCTest

class PreWorkoutInteractorTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: PreWorkoutInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupPreWorkoutInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: Test setup
  
  func setupPreWorkoutInteractor() {
    sut = PreWorkoutInteractor()
  }
  
  // MARK: Test doubles
  
  class PreWorkoutPresentationLogicSpy: PreWorkoutPresentationLogic {
    var presentSomethingCalled = false
    
    func presentUser(response: PreWorkout.FetchUser.Response) {
      presentSomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testFetchUserInfo() {
    // Given
    let spy = PreWorkoutPresentationLogicSpy()
    sut.presenter = spy
    let request = PreWorkout.FetchUser.Request()
    
    // When
    sut.fetchUserInfo(request: request)
    
    // Then
    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}