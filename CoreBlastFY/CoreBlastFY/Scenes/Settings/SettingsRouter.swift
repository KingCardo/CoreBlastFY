//
//  SettingsRouter.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 2/8/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SettingsRoutingLogic {
    func routeToAboutScene()
    func routeToNutritionScene()
    func routeToNotificationsScene()
    func routeToFoodLogScene()
    func routeToParksScene()
}

protocol SettingsDataPassing
{
  var dataStore: SettingsDataStore? { get }
}

class SettingsRouter: NSObject, SettingsRoutingLogic, SettingsDataPassing
{
  weak var viewController: SettingsViewController?
  var dataStore: SettingsDataStore?
  
  // MARK: Routing
    
    func routeToAboutScene() {
        
        let destination = AboutMeViewController()
        navigateTo(source: viewController!, destination: destination)
        
    }
    
    func routeToNutritionScene() {
        let destination = NutritonViewController()
        //destination.modalPresentationStyle = .blurOverFullScreen
        //destination.modalTransitionStyle = .crossDissolve
        navigateTo(source: viewController!, destination: destination)
    }
    
    func routeToNotificationsScene() {
        let destination = NotificationsViewController()
        navigateTo(source: viewController!, destination: destination)
    }
    
    func routeToFoodLogScene() {
        let destination = JournalViewController()
        navigateTo(source: viewController!, destination: destination)

    }
    
    func routeToParksScene() {
        let destination = ParksTableViewController()
        navigateTo(source: viewController!, destination: destination)
    }
  
  func routeToSomewhere(segue: UIStoryboardSegue?)
  {
//    if let segue = segue {
//      let destinationVC = segue.destination as! SomewhereViewController
//      var destinationDS = destinationVC.router!.dataStore!
//      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//    } else {
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//      var destinationDS = destinationVC.router!.dataStore!
//      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateTo(source: SettingsViewController, destination: UIViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: SettingsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
//}
