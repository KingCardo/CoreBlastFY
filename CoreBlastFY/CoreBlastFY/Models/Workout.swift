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
        switch user.totalPoints {
        case 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60: exercises = self.exercises.filter( { $0.isSide == false })
        case 1,4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61: exercises = self.exercises.filter( { $0.isSide == true })
        case 2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47,50,53,56,59: exercises = self.exercises.filter( { $0.totalBody == true })
        default: exercises = self.exercises
        }
        return exercises
    }
    
    var numberOfSets: Int {
        switch user.coreLevel {
        case .beginner: return 4
        case .novice: return 5
        case .solid: return 6
        case .advanced: return 6
        case .rockstar: return 6
        }
    }
    
    var numberOfExercises: Int {
        return exercisesToReturn.count
    }
    
    var workoutDuration: Double {
        return Double(((numberOfExercises) * secondsOfExercise) * numberOfSets)
    }
    
    var setDuration: Double {
        return workoutDuration / Double(numberOfSets)
    }
    
    var secondsOfExercise: Int {
        switch user.totalPoints {
        case 0...4: return 23
        case 5...15: return 28
        case 16...20: return 33
        case 21...25: return 38
        case 26...30: return 43
        case 31...35: return 48
        case 36...40: return 53
        case 41...45: return 58
        case 46...50: return 63
        default: return 70
        }
    }
}
