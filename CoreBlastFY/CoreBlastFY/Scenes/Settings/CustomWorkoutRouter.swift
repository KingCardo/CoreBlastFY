//
//  CustomWorkoutRouter.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 6/20/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CustomWorkoutRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CustomWorkoutDataPassing
{
  var dataStore: CustomWorkoutDataStore? { get }
}

class CustomWorkoutRouter: NSObject, CustomWorkoutRoutingLogic, CustomWorkoutDataPassing
{
  weak var viewController: CustomWorkoutViewController?
  var dataStore: CustomWorkoutDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: CustomWorkoutViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CustomWorkoutDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
