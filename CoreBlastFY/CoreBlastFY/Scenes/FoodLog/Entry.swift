//
//  Entry.swift
//  Journal
//
//  Created by Riccardo Washington on 5/22/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

struct Entry: Codable {
    var title: String
    var body: String
    var timeStamp: Date
    var entryType: EntryType
    var entryTypeIndex: Int? {
        return EntryType.all.firstIndex(of: entryType)
    }
    
    enum EntryType: String, Codable {
        case foodLog = "Food Log"
        case mental = "Mental Log"
        case physical = "Physical Log"
        case workout = "Workout Log"
        
        static var all: [EntryType] = [.foodLog, .mental, .physical, .workout]
        
        static var allString: [String] = [EntryType.foodLog.rawValue, EntryType.mental.rawValue, EntryType.physical.rawValue, EntryType.workout.rawValue]
    }
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.timeStamp == rhs.timeStamp
    }
}
