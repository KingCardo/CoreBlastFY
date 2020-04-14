//
//  PreWorkoutInteractor.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

protocol PreWorkoutBusinessLogic {
  func fetchUserInfo(request: PreWorkout.FetchUser.Request)
  //func fetchExercises(request: PreWorkout.FetchExercises.Request)
}

protocol PreWorkoutDataStore {
  var exercises: [Exercise] { get set }
}

class PreWorkoutInteractor: PreWorkoutBusinessLogic, PreWorkoutDataStore {
    
  var presenter: PreWorkoutPresentationLogic?
  var userInfoWorker: PreWorkoutWorker?
 // var exerciseFetchWorker: ExerciseWorker?
  //var user: User?
  var exercises: [Exercise] = ExerciseStorage.exercises
  
  // MARK: Do something
  
  func fetchUserInfo(request: PreWorkout.FetchUser.Request) {
    userInfoWorker = PreWorkoutWorker(userInfoStore: UserAPI())
    userInfoWorker?.fetchUserInfo() { user, error in
        if let error = error {
            // TO DO: Handle error
            print(error.localizedDescription)
        } else if let user = user {
           // self.user = user
            let response = PreWorkout.FetchUser.Response(user: user)
            print(user.selectedTime, "RWRW")
            self.presenter?.presentUser(response: response)
        }
    }
  }
}
