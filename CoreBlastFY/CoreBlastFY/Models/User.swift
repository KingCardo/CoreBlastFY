//
//  User.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/10/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

class User: Codable {
    
    init() {
        self.id = UUID()
    }
    let id: UUID?
    var name: String?
    var coreLevel: Level = .beginner
    var totalPoints: Int = 0
    var lastWorkoutComplete: Date?
    var nextWorkout: Date {
        guard let selectedTime = selectedTime else { return Date() + 86400 }
        
        return selectedTime.addingTimeInterval(86400)
    }
    
    var mode: Mode {
        if totalPoints % 3 == 0 {
            return .totalBody
        } else if totalPoints % 2 == 0 {
            return .side
        } else {
            return .front
        }
    }
    
    enum Mode: String, Codable {
        case totalBody
        case front
        case side
    }
    
    var selectedHour: Int?
    var selectedMinute: Int?
    
    var selectedTime: Date? {
        didSet {
            guard let selectedTime = selectedTime else { return }
           let (hour, minute) = getHourAndMinuteFromDate(date: selectedTime)
            selectedHour = hour
            selectedMinute = minute
        }
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
