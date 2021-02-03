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
    func routeToNotificationsScene()
    func routeToFoodLogScene()
    func routeToParksScene()
    func routeToTermsOfUse()
    func routeToProgramOverview()
    func routeToCustomWorkoutScene()
    func routeToExercises()
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
        let destination = GenericDetailViewController()
        destination.data = aboutMeData
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
    
    func routeToTermsOfUse() {
        let destination = GenericDetailViewController()
        destination.data = termsOfUse
        navigateTo(source: viewController!, destination: destination)
    }
    
    func routeToProgramOverview() {
        let destination = GenericDetailViewController()
        destination.data = programOverview
        navigateTo(source: viewController!, destination: destination)
    }
    
    func routeToCustomWorkoutScene() {
        let destination = CustomWorkoutViewController()
        navigateTo(source: viewController!, destination: destination)
        
    }
    func routeToExercises() {
        let destination = ExerciseViewController()
         navigateTo(source: viewController!, destination: destination)
//        self.exercisesNavVC = UINavigationController(rootViewController: exerciseVC)
//        self.exercisesNavVC.navigationBar.barStyle = .black
//        self.exercisesNavVC.navigationBar.tintColor = .white
//        self.exercisesNavVC.tabBarItem = UITabBarItem(title: "Exercises", image: #imageLiteral(resourceName: "exercises"), selectedImage: nil)
//        self.exercisesNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

  }

  // MARK: Navigation
  
  func navigateTo(source: SettingsViewController, destination: UIViewController)
  {
    source.show(destination, sender: nil)
  }
  
