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
    var image: UIImage?
    var breakfast: Recipe?
    var lunch: Recipe?
    var dinner: Recipe?
    var snack: Recipe?
    var dinner2: Recipe?
    var tip: String
    var whatToAvoid: String?
    var whatToEat: String?
    var guidelines: String?
    

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
    var mealType: MealType
    let ingredients: [String]
    let instructions: [String]
    let image: UIImage?
    
    enum MealType: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snack = "Snack"
    }
    
    init(name: String, ingredients: [String], instructions: [String], mealType: MealType, image: UIImage?) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.mealType = mealType
        self.image = image
    }
}

let recipe = Recipe(name: "Eggs and Sauage", ingredients: ["Eggs", "Sausage"], instructions: ["Boil Eggs", "Heat up pan with olive oil", "Cook sausage for 10 minutes over medium heat"], mealType: .breakfast, image: #imageLiteral(resourceName: "nutrition"))
