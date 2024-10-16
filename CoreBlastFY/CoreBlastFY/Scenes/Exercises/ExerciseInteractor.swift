//
//  ExerciseInteractor.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/19/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ExerciseBusinessLogic {
  func getExercises(request: Exercises.Videos.Request)
}

protocol ExerciseDataStore {
  var exercises: [Exercise] { get set }
}

class ExerciseInteractor: ExerciseBusinessLogic, ExerciseDataStore {
  var presenter: ExercisePresentationLogic?
  var worker: ExerciseWorker?
  var exercises: [Exercise] = ExerciseStorage.exercises
  
  // MARK: Do something
  
  func getExercises(request: Exercises.Videos.Request) {
    exercises = ExerciseStorage.exercises
    
    let response = Exercises.Videos.Response(exercises: exercises)
    presenter?.presentExercises(response: response)
  }
}
