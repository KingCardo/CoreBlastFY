//
//  User.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/10/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

class User: Codable {
    let id = UUID()
    var name: String?
    var coreLevel: Level = .beginner
    var totalPoints: Int = 0
    var lastWorkoutComplete: Date?
    var nextWorkout: Date {
        return Date() + 86400
       // return lastWorkoutComplete != nil ? (lastWorkoutComplete! + 86400) : nil
    }
    
    enum Level: String, Codable, CaseIterable {
        case beginner = "Beginner"
        case novice = "Novice"
        case solid = "Solid"
        case advanced = "Advanced"
        case rockstar = "Rockstar"
    }
    
    
    var nextLevelUp: Int {
        switch coreLevel {
        case .beginner: return 15
        case .novice: return 30
        case .solid: return 45
        case .advanced: return 60
        case .rockstar: return 90
        }
    }
    
    var nextLevel: Level {
        switch coreLevel {
        case .beginner: return .novice
        case .novice: return .solid
        case .solid: return .advanced
        case .advanced, .rockstar: return .rockstar
        }
    }
    
}

extension User: Equatable {
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
