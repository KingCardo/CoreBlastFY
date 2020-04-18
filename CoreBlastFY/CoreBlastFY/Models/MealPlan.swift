//
//  MealPlan.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

struct MealPlan {
    let title: String
    let summary: String
    let imageData: Data?
    let description: String
    
    init(title: String, summary: String, imageData: Data?, description: String) {
        self.title = title
        self.summary = summary
        self.imageData = imageData
        self.description = description
    }
}
