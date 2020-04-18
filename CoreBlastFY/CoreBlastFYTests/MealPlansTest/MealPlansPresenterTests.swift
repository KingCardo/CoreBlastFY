//
//  MealPlansPresenterTests.swift
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

class MealPlansPresenterTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: MealPlansPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupMealPlansPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: Test setup
  
  func setupMealPlansPresenter() {
    sut = MealPlansPresenter()
  }
  
  // MARK: Test doubles
  
  class MealPlansDisplayLogicSpy: MealPlansDisplayLogic
  {
    func displayPlans(viewModel: MealPlans.GetPlan.ViewModel) {
        displaySomethingCalled = true
    }
    
    var displaySomethingCalled = false
  }
  
  // MARK: Tests
  
  func testPresentMealPlansOverview() {
    // Given
    let spy = MealPlansDisplayLogicSpy()
    sut.viewController = spy
    let mockMP = MealPlan(title: "demo", summary: "demo", imageData: nil, description: "heyhde")
    let response = MealPlans.GetPlan.Response(mealPlans: [mockMP])
    
    // When
    sut.presentMealPlansOverview(response: response)
    
    // Then
    XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}