//
//  WorkoutPresenter.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

protocol WorkoutPresentationLogic {
    func presentWorkout(response: WorkoutInfo.FetchWorkout.Response)
    func presentCustomWorkout(response: WorkoutInfo.FetchWorkout.Response)
}

class WorkoutPresenter: WorkoutPresentationLogic {
    weak var viewController: WorkoutDisplayLogic?
    
    func timeString(time: TimeInterval) -> String {
        let interval = Int(time)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hour = (interval / 3600)
        return String(format:"%02i:%02i:%02i", hour, minutes, seconds)
        
    }
    // MARK: Do something
    
    func presentWorkout(response: WorkoutInfo.FetchWorkout.Response) {
        let workout = response.workout
        
        let workoutDetails = WorkoutInfo.FetchWorkout.ViewModel.WorkoutDetails(
            secondsOfExercise: Double(workout.secondsOfExercise),
            setDuration: workout.setDuration,
            workoutDuration:
            timeString(time: workout.workoutDuration),
            workoutDurationDouble: workout.workoutDuration,
            numberOfSets: "\(workout.numberOfSets)",
            exercises: workout.exercisesToReturn)
        let viewModel = WorkoutInfo.FetchWorkout.ViewModel(workoutDetails: workoutDetails)
        viewController?.displayWorkout(viewModel: viewModel)
    }
    
    func presentCustomWorkout(response: WorkoutInfo.FetchWorkout.Response) {
        let workout = response.workout
        
        let workoutDetails = WorkoutInfo.FetchWorkout.ViewModel.WorkoutDetails(
            secondsOfExercise: Double(workout.customSecondsOfExercise!),
            setDuration: workout.customSetDuration,
            workoutDuration:
            timeString(time: workout.customWorkoutDuration),
            workoutDurationDouble: workout.customWorkoutDuration,
            numberOfSets: "\(String(describing: workout.customNumberOfSets!))",
            exercises: workout.exercises)
        let viewModel = WorkoutInfo.FetchWorkout.ViewModel(workoutDetails: workoutDetails)
        viewController?.displayWorkout(viewModel: viewModel)
    }
}
