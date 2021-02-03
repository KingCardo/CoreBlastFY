//
//  Exercise.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/10/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

struct Exercise: Codable, Equatable {
    var name: String
    var tip: String
    var movement: Movement = .stationary
    var level: Exercise.Level?
    var videoURL: URL?
    var videoData: Data?
    var type: ExerciseType = .core
    var isSide: Bool
    var totalBody: Bool
    
    enum ExerciseType: String, Codable {
        case core
        case legs
        case back
        case chest
        case arms
        
    }
    
    enum Level: String, Codable, CaseIterable {
        case beginner
        case novice
        case solid
        case advanced
        case rockstar
    }
    
    enum Movement: String, Codable {
        case stationary
        case dynamic
        case dynamicWeighted
        case explosive
    }
    
    init(name: String, tip: String = "", level: Exercise.Level, movement: Movement, isSide: Bool = false, totalBody: Bool = false) {
        self.name = name
        self.tip = tip
        let s = Bundle.main.path(forResource: "\(self.name)", ofType: "mov")!
        let path = URL(fileURLWithPath: s)
        self.videoURL = path
        self.level = level
        self.isSide = isSide
        self.totalBody = totalBody
    }
    
}
