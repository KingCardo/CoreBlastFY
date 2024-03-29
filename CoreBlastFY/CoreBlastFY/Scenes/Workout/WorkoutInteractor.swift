//
//  WorkoutInteractor.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import Foundation

protocol WorkoutBusinessLogic {
    func fetchWorkout(request: WorkoutInfo.FetchWorkout.Request)
    func createCustomWorkout(workout: Workout)
}

protocol WorkoutDataStore {
    var workout: Workout? { get set }
    var exercises: [Exercise] { get set }
}

class WorkoutInteractor: WorkoutBusinessLogic, WorkoutDataStore {
    
    var presenter: WorkoutPresentationLogic?
    var worker: WorkoutWorker?
    var workout: Workout?
    var exercises: [Exercise] = []
    
    
    // MARK: Do something
    
    func createCustomWorkout(workout: Workout) {
        let response = WorkoutInfo.FetchWorkout.Response(workout: workout)
        presenter?.presentCustomWorkout(response: response)
    }
    
    func fetchWorkout(request: WorkoutInfo.FetchWorkout.Request) {
        guard let workout = self.workout else { return }
            let response = WorkoutInfo.FetchWorkout.Response(workout: workout)
            self.presenter?.presentWorkout(response: response)
    }
}
