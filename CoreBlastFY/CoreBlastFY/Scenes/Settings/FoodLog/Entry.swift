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
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.timeStamp == rhs.timeStamp
    }
}
