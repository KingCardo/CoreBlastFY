//
//  ExercisePresenterTests.swift
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

class ExercisePresenterTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: ExercisePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupExercisePresenter()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: Test setup
  
  func setupExercisePresenter() {
    sut = ExercisePresenter()
  }
  
  // MARK: Test doubles
  
    class ExerciseDisplayLogicSpy: ExerciseDisplayLogic {
        func displayExercises(viewModel: Exercises.Videos.ViewModel) {
            displaySomethingCalled = true
        }
        
    var displaySomethingCalled = false
    
  }
  
  // MARK: Tests
  
  func testPresentExercises() {
    // Given
    let spy = ExerciseDisplayLogicSpy()
    sut.viewController = spy
    let response = Exercises.Videos.Response(exercises: [Exercise(name: "a", level: .rockstar, movement: .dynamic, videoURL: URL(string: "www.apple.com")!)])
    
    // When
    sut.presentExercises(response: response)
    
    // Then
    XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}
