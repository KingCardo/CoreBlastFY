//
//  MealPlansRouter.swift
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

@objc protocol MealPlansRoutingLogic {
    func routeToMealPlanDetailController()
}

protocol MealPlansDataPassing {
    var dataStore: MealPlansDataStore? { get }
}

class MealPlansRouter: NSObject, MealPlansRoutingLogic, MealPlansDataPassing {
    weak var viewController: MealPlansViewController?
    var dataStore: MealPlansDataStore?
    
    // MARK: Routing
    
    func routeToMealPlanDetailController() {
        guard let source = viewController else { return }
        let destinationVC = MealPlanDetailViewController()
        guard let dataStore = dataStore else { return }
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        passMealPlanToDetailController(source: dataStore, destination: &destinationDS)
        navigateToMealPlanDetailController(source: source, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    private func navigateToMealPlanDetailController(source: MealPlansViewController, destination: MealPlanDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    private func passMealPlanToDetailController(source: MealPlansDataStore, destination: inout MealPlanDetailDataStore) {
        let selectedRow = viewController?.collectionView.indexPathsForSelectedItems?.first?.item
        destination.mealPlan = source.mealPlans?[selectedRow!]
    }
}
