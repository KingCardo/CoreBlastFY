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
        
        let rest = self.exercises.filter({ $0.name == "up-dog"})
        
        switch user.coreLevel {
        case .beginner:
            exercises = self.exercises.filter({$0.level == .beginner })
        case .novice:
            exercises = self.exercises.filter({$0.level == .novice })
            exercises += rest
        case .solid:
            exercises = self.exercises.filter({$0.level == .solid })
            exercises += rest
        case .advanced:
            exercises = self.exercises.filter({$0.level == .advanced })
            exercises += rest
        case .rockstar:
            exercises = self.exercises.filter({$0.level == .rockstar })
            exercises += self.exercises.filter({$0.level == .advanced })
            exercises += rest
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
