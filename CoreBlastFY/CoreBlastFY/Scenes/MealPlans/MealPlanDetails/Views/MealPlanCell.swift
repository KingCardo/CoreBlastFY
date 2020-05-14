//
//  WorkoutCell.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/2/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class MealPlanCell: UITableViewCell {
    static let id = "MealPlanCell"
    
    var mealPlanView = MealPlanView()
    var item: MealPlanDetail.FetchDetails.ViewModel.DisplayMealPlanDetails? {
        didSet {
            mealPlanView.item = item
        }
    }
    weak var parent: MealPlanDetailViewController?
    
    func routeToMealDetails(with recipe: Recipe?) {
        parent?.routeToMealDetails(with: recipe)
    }
    
    func routeToTipDetails(with tip: String) {
        parent?.routeToTipDetails(with: tip)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setup()
        mealPlanView.parent = self
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        contentView.addSubview(mealPlanView)
        mealPlanView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
}
