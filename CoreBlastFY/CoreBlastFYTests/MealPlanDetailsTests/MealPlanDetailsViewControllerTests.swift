//
//  MealPlanDetailsViewControllerTests.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/18/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CoreBlastFY
import XCTest

class MealPlanDetailsViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MealPlanDetailViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupMealPlanDetailsViewController()
  }
  
  override func tearDown() {
    window = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMealPlanDetailsViewController() {
    sut = MealPlanDetailViewController()
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
    class MealPlanDetailsBusinessLogicSpy: MealPlanDetailBusinessLogic, MealPlanDetailDataStore {
    var mealPlan: MealPlan?
        
    var doSomethingCalled = false
    
    func fetchMealPlanDetails(request: MealPlanDetail.FetchDetails.Request) {
      doSomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldDoSomethingWhenViewIsLoaded() {
    // Given
    let spy = MealPlanDetailsBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
  }
  
  func testDisplaySomething() {
    let mockDisplayedPlan = MealPlanDetail.FetchDetails.ViewModel.DisplayMealPlanDetails.init(title: "mock", summary: "mock", description: "mick", planImage: nil)
    // Given
    let viewModel = MealPlanDetail.FetchDetails.ViewModel(displayedPlan: mockDisplayedPlan)
    
    // When
    loadView()
    sut.displayMealPlanDetails(viewModel: viewModel)
    
    // Then
    //XCTAssertEqual(sut.view.backgroundColor, UIColor.red, "displaySomething(viewModel:) should update the name text field")
  }
}