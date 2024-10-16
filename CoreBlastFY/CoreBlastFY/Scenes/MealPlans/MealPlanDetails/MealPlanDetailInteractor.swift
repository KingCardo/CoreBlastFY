//
//  MealPlanDetailInteractor.swift
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

protocol MealPlanDetailBusinessLogic {
  func fetchMealPlanDetails(request: MealPlanDetail.FetchDetails.Request)
}

protocol MealPlanDetailDataStore {
    var mealPlan: MealPlan? { get set }
    var recipe: Recipe? { get set }
}

class MealPlanDetailInteractor: MealPlanDetailBusinessLogic, MealPlanDetailDataStore {
    var presenter: MealPlanDetailPresentationLogic?
    var mealPlan: MealPlan?
    var recipe: Recipe?
    
    // MARK: Do something
    
    func fetchMealPlanDetails(request: MealPlanDetail.FetchDetails.Request) {
        guard let mealPlan = mealPlan else { return }
        
        let response = MealPlanDetail.FetchDetails.Response(mealPlan: mealPlan)
        presenter?.presentMealPlanDetails(response: response)
    }
}
