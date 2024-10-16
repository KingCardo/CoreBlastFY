//
//  ExerciseInteractorTests.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/19/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CoreBlastFY
import XCTest

class ExerciseInteractorTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: ExerciseInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupExerciseInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: Test setup
  
  func setupExerciseInteractor() {
    sut = ExerciseInteractor()
  }
  
  // MARK: Test doubles
  
  class ExercisePresentationLogicSpy: ExercisePresentationLogic {
    var presentSomethingCalled = false
    
    func presentExercises(response: Exercises.Videos.Response) {
      presentSomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testGetExercises() {
    // Given
    let spy = ExercisePresentationLogicSpy()
    sut.presenter = spy
    let request = Exercises.Videos.Request()
    
    // When
    sut.getExercises(request: request)
    
    // Then
    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
