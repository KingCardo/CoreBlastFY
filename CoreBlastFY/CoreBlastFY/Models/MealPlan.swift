//
//  MealPlan.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

struct MealPlan {
    let title: String
    let summary: String
    let description: String
    let image: UIImage?
    let breakfast: Recipe?
    let lunch: Recipe?
    let dinner: Recipe?
    let snack: Recipe?
    let dinner2: Recipe?
    let tip: String
    let whatToAvoid: String?
    let whatToEat: String?
    let guidelines: String?
    

    init(title: String, summary: String, description: String, image: UIImage?, breakfast: Recipe? = nil, lunch: Recipe? = nil, dinner: Recipe? = nil, snack: Recipe? = nil, dinner2: Recipe? = nil, tip: String, whatToAvoid: String? = nil, whatToEat: String? = nil, guidelines: String? = nil) {
        self.title = title
        self.summary = summary
        self.description = description
        self.image = image
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.snack = snack
        self.dinner2 = dinner2
        self.tip = tip
        self.whatToAvoid = whatToAvoid
        self.whatToEat = whatToEat
        self.guidelines = guidelines
    }
}

struct Recipe {
    let name: String
    let mealType: MealType
    let ingredients: [Ingredient]
    let instructions: [String]
    let image: UIImage?
    
    struct Ingredient {
        let name: String
        let amount: String
    }
    
    enum MealType: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snack = "Snack"
    }
    
    init(name: String, ingredients: [Ingredient], instructions: [String], mealType: MealType, image: UIImage?) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.mealType = mealType
        self.image = image
    }
}
