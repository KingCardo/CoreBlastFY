//
//  RecipeDescriptionCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/27/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class RecipeDescriptionCollectionViewCell: UICollectionViewCell {
    static let id = "RecipeDescriptionCollectionViewCell"
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.makeAvenirNext(size: 28)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipeImage: MealDetails.RecipeDetails.ViewModel.RecipeDetails?) {
        descriptionLabel.text = recipeImage?.title
    }
    
    private func setupViews() {
        addSubview(descriptionLabel)
        descriptionLabel.centerYInSuperview()
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: RecipeDescriptionCollectionViewCell.Constants.descriptionLeading).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -RecipeDescriptionCollectionViewCell.Constants.descriptionLeading).isActive = true
    }
}

extension RecipeDescriptionCollectionViewCell {
    struct Constants {
        static let descriptionLeading: CGFloat = 8
    }
}
