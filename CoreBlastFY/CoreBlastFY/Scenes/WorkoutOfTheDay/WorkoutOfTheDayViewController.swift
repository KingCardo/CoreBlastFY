//
//  WorkoutOfTheDayViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 8/8/21.
//  Copyright (c) 2021 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WorkoutOfTheDayDisplayLogic: AnyObject
{
  func displaySomething(viewModel: WorkoutOfTheDay.Something.ViewModel)
}

class WorkoutOfTheDayViewController: UIViewController, WorkoutOfTheDayDisplayLogic
{
  var interactor: WorkoutOfTheDayBusinessLogic?
  var router: (NSObjectProtocol & WorkoutOfTheDayRoutingLogic & WorkoutOfTheDayDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = WorkoutOfTheDayInteractor()
    let presenter = WorkoutOfTheDayPresenter()
    let router = WorkoutOfTheDayRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = WorkoutOfTheDay.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: WorkoutOfTheDay.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
