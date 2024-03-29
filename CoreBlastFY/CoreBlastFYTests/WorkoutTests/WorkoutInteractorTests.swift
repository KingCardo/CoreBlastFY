//
//  WorkoutInteractorTests.swift
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

class WorkoutInteractorTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: WorkoutInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupWorkoutInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: Test setup
  
  func setupWorkoutInteractor() {
    sut = WorkoutInteractor()
  }
  
  // MARK: Test doubles
  
  class WorkoutPresentationLogicSpy: WorkoutPresentationLogic {
    var presentSomethingCalled = false
    
    func presentWorkout(response: WorkoutInfo.FetchWorkout.Response) {
      presentSomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testFetchWorkout() {
    // Given
    let spy = WorkoutPresentationLogicSpy()
    sut.presenter = spy
    let mockExercises = [Exercise(name: "squat", level: .beginner, movement: .dynamic)]
    let request = WorkoutInfo.FetchWorkout.Request(exercises: mockExercises)
    
    // When
    sut.fetchWorkout(request: request)
    
    // Then
    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
