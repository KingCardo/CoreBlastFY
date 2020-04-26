//
//  MealDetailsModels.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MealDetails
{
    // MARK: Use cases
    
    enum RecipeDetails
    {
        struct Request
        {
        }
        struct Response
        {
            var recipe: Recipe?
        }
        struct ViewModel
        {
            struct RecipeDetails {
                var title: String
                var summary: String
                var image: UIImage?
                var ingredients: [Ingredients]
                var instructions: [String]
            }
            
            struct Ingredients {
                let name: String
                let amount: String
            }
            var recipeDetails: RecipeDetails
        }
    }
}
