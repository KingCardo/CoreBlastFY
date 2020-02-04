//
//  ProgressionPic.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

struct ProgressionPic: Codable {
    
    var progressionPicData: Data?
    var timestamp: Date
    
    var photo: UIImage? {
        get {
            guard let picData = progressionPicData else { return #imageLiteral(resourceName: "scott-webb-22437")}
            return UIImage(data: picData)
        }
    }
    
    init(timestamp: Date, progressionPicData: Data?) {
        self.timestamp = timestamp
        self.progressionPicData = progressionPicData
    }
}

extension ProgressionPic: Equatable {
    static func == (lhs: ProgressionPic, rhs: ProgressionPic) -> Bool {
        return lhs.timestamp == rhs.timestamp
}
}
