//
//  UserViewModel.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

struct UserViewModel {
     let totalPoints: String
     let coreLevel: String
     let nextLevel: String
    
    init(user: User) {
        self.totalPoints = "\(user.totalPoints)"
        self.coreLevel = user.coreLevel.rawValue
        self.nextLevel = "\(user.nextLevelUp)"
    }
}
