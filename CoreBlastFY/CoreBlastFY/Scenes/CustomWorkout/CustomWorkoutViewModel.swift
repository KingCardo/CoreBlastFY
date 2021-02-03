//
//  CustomWorkoutViewModel.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class CustomWorkoutViewModel {
    
    var workout: Workout?
    
    private(set) var exercises: [Exercise] = [] {
        didSet {
            guard exercises.count > 1 else { return }
            workout = createWorkout(sets: numberOfSets, duration: durationOfExercise, exercises: exercises)
        }
    }
    
    var numberOfSets: Int?
    var durationOfExercise: Int?
    
    func createWorkout(sets: Int?, duration: Int?, exercises: [Exercise]) -> Workout? {
        guard let numberOfSets = numberOfSets, let durationOfExercise = durationOfExercise else { return nil }
        
        return Workout(exercises: exercises, numberOfSets: numberOfSets, duration: durationOfExercise)
    }
    
    func addExercises(exercises: [Exercise]) {
        self.exercises = exercises
    }
    
    func reset() {
        workout = nil
        numberOfSets = nil
        durationOfExercise = nil
        exercises = []
    }
}
