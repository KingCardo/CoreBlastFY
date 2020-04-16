//
//  WorkoutViewControllerTests.swift
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

class WorkoutViewControllerTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: WorkoutViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupWorkoutViewController()
  }
  
  override func tearDown() {
    window = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupWorkoutViewController() {
    sut = WorkoutViewController()
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
    class WorkoutBusinessLogicSpy: WorkoutBusinessLogic, WorkoutDataStore {
        var workout: Workout? = nil
        
        var exercises: [Exercise] = []
        
    var doSomethingCalled = false
        
        func fetchWorkout(request: WorkoutInfo.FetchWorkout.Request) {
            doSomethingCalled = true
        }
  }
  
  // MARK: Tests
  
  func testShouldDoSomethingWhenViewIsLoaded() {
    // Given
    let spy = WorkoutBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
  }
  
  func testDisplayWorkout() {
    // Given
    let viewModel = WorkoutInfo.FetchWorkout.ViewModel(workoutDetails: WorkoutInfo.FetchWorkout.ViewModel.WorkoutDetails(secondsOfExercise: 30, setDuration: 40, workoutDuration: "5", workoutDurationDouble: 400, numberOfSets: "5", exercises: []))
    
    // When
    loadView()
    sut.displayWorkout(viewModel: viewModel)
    
    // Then
    XCTAssertNotNil(sut.workoutView, "displaySomething(viewModel:) should update the name text field")
  }
}
