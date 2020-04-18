//
//  MealPlansPresenter.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/16/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MealPlansPresentationLogic {
  func presentMealPlansOverview(response: MealPlans.GetPlan.Response)
}

class MealPlansPresenter: MealPlansPresentationLogic {
  weak var viewController: MealPlansDisplayLogic?
  
  // MARK: Do something
  
  func presentMealPlansOverview(response: MealPlans.GetPlan.Response) {
    let planOverviews = response.mealPlans.map( { MealPlans.GetPlan.ViewModel.PlanOverview(title: $0.title, summary: $0.summary, image: nil) })
    
    let viewModel = MealPlans.GetPlan.ViewModel(planOverViews: planOverviews)
    viewController?.displayPlans(viewModel: viewModel)
  }
}