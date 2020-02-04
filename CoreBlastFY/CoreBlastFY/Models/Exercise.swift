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
    var type: Movement = .stationary
    var level: Exercise.Level?
    var video: URL?
   // var downloadUrl: URL? {
//        return URL(string: videoURL)
//    }
    
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
        case sixPack
       // case rest
    }
    
    init(name: String, tip: String = "", videoURL: String = "") {
        self.name = name
        self.tip = tip
        self.video = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
       // self.videoURL = videoURL
    }
    
    init?(record: CKRecord) {
        self.name = record["name"] as? String ?? ""
        self.tip = record["tip"] as? String ?? ""
        let level = record["level"] as? String ?? ""
        self.level = Exercise.Level(rawValue: level) ?? .beginner
        let type = record["type"] as? String ?? ""
        self.type = Exercise.Movement(rawValue: type) ?? .stationary
        if let asset = record["video"] as? CKAsset {
            self.video = asset.fileURL
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
