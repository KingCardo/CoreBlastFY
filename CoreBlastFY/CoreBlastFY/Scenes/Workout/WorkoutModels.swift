//
//  WorkoutModels.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

enum WorkoutInfo
{
    // MARK: Use cases
    
    enum FetchWorkout {
        struct Request {
            var exercises: [Exercise]
        }
        struct Response {
            var workout: Workout
        }
        struct ViewModel {
            struct WorkoutDetails {
                let secondsOfExercise: TimeInterval
                let setDuration: TimeInterval
                let workoutDuration: String
                let workoutDurationDouble: TimeInterval
                let numberOfSets: String
                let exercises: [Exercise]
            }
            var workoutDetails: WorkoutDetails
        }
    }
}
