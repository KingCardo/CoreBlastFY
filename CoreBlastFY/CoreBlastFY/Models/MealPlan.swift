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
    
    init(title: String, summary: String, imageData: Data?) {
        self.title = title
        self.summary = summary
        self.imageData = imageData
    }
    
}

let mockMP1 = MealPlan(title: "Shredded Meal Plan", summary: "Accelerate your gains with this fat burning plan!", imageData: Data())
let mockMP2 = MealPlan(title: "Sample Grocery List", summary: "Have no idea wht you should be eating? This is for you!", imageData: Data())
let mockMP3 = MealPlan(title: "Gain while Chisel", summary: "This plan lets you gain muscle mass while making six pack gains!", imageData: Data())
let mockMP4 = MealPlan(title: "Franchiz Perosnal Plan", summary: "This is my current meal plan for the maintenance phase when you get where you want to be!", imageData: Data())

let allMPs = [mockMP1, mockMP2, mockMP3, mockMP4]
