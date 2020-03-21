//
//  Exercise.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/10/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation
import CloudKit

struct Exercise: Codable {
    var name: String
    var tip: String
    var movement: Movement = .stationary
    var level: Exercise.Level?
    var videoURL: URL?
    var videoData: Data?
    var type: ExerciseType = .core
    
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
    
    init(name: String, tip: String = "", level: Exercise.Level, movement: Movement, videoURL: URL) {
        self.name = name
        self.tip = tip
        //let path = URL(fileURLWithPath:Bundle.main.path(forResource: "\(self.name)", ofType: "mov")!)
        self.videoURL = videoURL//path//videoURL
        self.level = level
    }
    
    init?(record: CKRecord) {
        self.name = record["name"] as? String ?? ""
        self.tip = record["tip"] as? String ?? ""
        let level = record["level"] as? String ?? ""
        self.level = Exercise.Level(rawValue: level) ?? .beginner
        let movement = record["type"] as? String ?? ""
        self.movement = Exercise.Movement(rawValue: movement) ?? .stationary
        let exerciseType = record["exerciseType"] as? String ?? ""
        self.type = Exercise.ExerciseType(rawValue: exerciseType) ?? .core
        if let asset = record["video"] as? CKAsset {
            self.videoURL = asset.fileURL!
            do {
                let data = try Data(contentsOf: self.videoURL!)
                self.videoData = data
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let archiveURL = documentsDirectory.appendingPathComponent("\(self.name)").appendingPathExtension("mov")
                try? videoData?.write(to: archiveURL)
                self.videoURL = archiveURL
            } catch let error {
                print(error)
            }
        }
    }
    
//    init(dictionary: [String: Any]) {
//        let value = dictionary["level"] as? String ?? ""
//        self.level = Exercise.Level(rawValue: value) ?? .beginner
//        self.name = dictionary["name"] as? String ?? ""
//        self.tip = dictionary["tip"] as? String ?? ""
//        let url = dictionary["videoURL"] as? String ?? ""
//        self.videoURL = "videos/\(url)"
//        let type = dictionary["type"] as? String ?? ""
//        self.type = Exercise.Movement(rawValue: type) ?? .stationary
//
//    }
}
