//
//  PreWorkoutRouter.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

@objc protocol PreWorkoutRoutingLogic {
  func routeToWorkoutScene()
}

protocol PreWorkoutDataPassing {
  var preWorkoutDataStore: PreWorkoutDataStore? { get set }
}

class PreWorkoutRouter: NSObject, PreWorkoutRoutingLogic, PreWorkoutDataPassing {
    
  weak var viewController: PreWorkoutViewController?
  var preWorkoutDataStore: PreWorkoutDataStore?
  
  // MARK: Routing
  
    func routeToWorkoutScene() {
      
        guard let source = viewController else { return }
        let destination = WorkoutViewController()
        
        guard let preWorkoutDataStore = preWorkoutDataStore else { return }
        guard var destinationDataStore = destination.router?.dataStore else { return }
        passExercisesToWorkoutScene(source: preWorkoutDataStore, destination: &destinationDataStore)
        navigateToWorkoutScene(source: source, destination: destination)
        
    }

  // MARK: Navigation
  
  private func navigateToWorkoutScene(source: PreWorkoutViewController, destination: WorkoutViewController) {
    source.show(destination, sender: nil)
  }

  // MARK: Passing data

 private func passExercisesToWorkoutScene(source: PreWorkoutDataStore, destination: inout WorkoutDataStore) {
      destination.exercises = source.exercises
      destination.workout = source.workout
  }
}

