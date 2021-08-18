//
//  WorkoutRouter.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

protocol WorkoutRoutingLogic {
  func routeToPreWorkoutScene()
}

protocol WorkoutDataPassing {
  var dataStore: WorkoutDataStore? { get }
}

class WorkoutRouter: NSObject, WorkoutRoutingLogic, WorkoutDataPassing {
    
  weak var viewController: WorkoutViewController?
  var dataStore: WorkoutDataStore?
  
  // MARK: Routing
    
    func routeToPreWorkoutScene() {
        guard let source = viewController else { return }
        let destination = PreWorkoutViewController()
        navigateToPreWorkoutScene(source: source, destination: destination)
    }

  // MARK: Navigation
  
  private func navigateToPreWorkoutScene(source: WorkoutViewController, destination: PreWorkoutViewController) {
    source.show(destination, sender: nil)
  }
  
}
