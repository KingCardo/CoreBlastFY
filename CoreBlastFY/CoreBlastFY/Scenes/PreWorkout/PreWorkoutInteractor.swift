//
//  PreWorkoutInteractor.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//


import Foundation

protocol PreWorkoutBusinessLogic {
    func fetchUserInfo(request: PreWorkout.FetchUser.Request)
    func fetchWorkout(request: WorkoutInfo.FetchWorkout.Request)
}

protocol PreWorkoutDataStore {
    var exercises: [Exercise] { get set }
    var workout: Workout? { get set }
}

class PreWorkoutInteractor: PreWorkoutBusinessLogic, PreWorkoutDataStore {
    
    var presenter: PreWorkoutPresentationLogic?
    var userInfoWorker: PreWorkoutWorker?
    var exercises: [Exercise] = []
    var worker: WorkoutWorker?
    var workout: Workout?
  
  // MARK: Do something
  
  func fetchUserInfo(request: PreWorkout.FetchUser.Request) {
    userInfoWorker = PreWorkoutWorker(userInfoStore: UserAPI())
    userInfoWorker?.fetchUserInfo() { user, error in
        if let error = error {
            // TO DO: Handle error
            print(error.localizedDescription)
        } else if let user = user {
            let response = PreWorkout.FetchUser.Response(user: user)
            self.presenter?.presentUser(response: response)
        }
    }
  }
    
    func fetchWorkout(request: WorkoutInfo.FetchWorkout.Request) {
        worker = WorkoutWorker(dataStore: exercises)
        worker?.fetchWorkout(completion: { (workout) in
            self.workout = workout
            self.exercises = workout.exercises
        })
    }
}
