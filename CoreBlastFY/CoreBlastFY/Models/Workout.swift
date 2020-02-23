//
//  Workout.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/10/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

struct Workout: Codable {
    
    init(user: User, exercises: [Exercise]) {
        self.user = user
        self.exercises = exercises
    }
    
    var user: User
    var exercises: [Exercise]
    
    var exercisesToReturn: [Exercise] {
        var exercises: [Exercise]
        let rest = Exercise(name: "Rest", tip: "Inhale thru nose, exhale thru mouth", level: .beginner, type: .stationary, videoURL: squatVideoPath)//Exercise(name: "Rest", tip: "Inhale thru nose, exhale thru mouth")
        
        switch user.coreLevel {
            
        case .beginner:
            exercises = self.exercises.filter({$0.level == .beginner })
            exercises.append(rest)
            return exercises
        case .novice:
            exercises = self.exercises.filter({$0.level == .novice })
            exercises.append(rest)
            return exercises
        case .solid:
            exercises = self.exercises.filter({$0.level == .solid })
            exercises.append(rest)
            return exercises
        case .advanced:
            exercises = self.exercises.filter({$0.level == .advanced })
            exercises.append(rest)
            return exercises
        case .rockstar:
            exercises = self.exercises.filter({$0.level == .rockstar })
            exercises.append(rest)
            return exercises
        }
    }
    
    
    var numberOfSets: Int {
        switch user.coreLevel {
        case .beginner: return 4
        case .novice: return 5
        case .solid: return 6
        case .advanced: return 7
        case .rockstar: return 8
        }
    }
    
    var numberOfExercises: Int {
        return exercises.count
    }
    
    var workoutDuration: Double {
        switch user.coreLevel {
        default: return Double(((numberOfExercises - 1) * secondsOfExercise + (secondsOfRest)) * numberOfSets)
        }
    }
    
    var setDuration: Double {
        return workoutDuration / Double(numberOfSets)
    }
    
    var secondsOfExercise: Int {
        switch user.coreLevel {
        case .beginner: return 15
        case .novice: return 25
        case .solid: return 40
        case .advanced: return 55
        case .rockstar: return 70
        }
    }
    
    var secondsOfRest: Int {
        switch user.coreLevel {
        case .beginner: return 15
        case .novice: return 10
        case .solid: return 5
        case .advanced: return 3
        case .rockstar: return 1
        }
    }
}
