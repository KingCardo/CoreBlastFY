//
//  MealPlanDetailModels.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/18/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MealPlanDetail
{
  // MARK: Use cases
  
  enum FetchDetails
  {
    struct Request
    {
    }
    struct Response
    {
        var mealPlan: MealPlan
    }
    struct ViewModel
    {
        struct DisplayMealPlanDetails {
            var title: String
            var summary: String
            var description: String
            var planImage: UIImage?
            var recipe: [Recipe?]
            var isTips: Bool
            var tips: [String?]
        }
        var displayedPlan: DisplayMealPlanDetails
    }
  }
}
