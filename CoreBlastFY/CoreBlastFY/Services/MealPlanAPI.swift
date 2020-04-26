//
//  MealPlanAPI.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

class MealPlanAPI: GetPlansOverviewStore {
    
    var mealPlans: [MealPlan] = allMPs
    
    func fetchPlansOverview(completion: @escaping ([MealPlan], GetPlansOverviewStoreError?) -> Void) {
        completion(mealPlans, nil)
    }
}





