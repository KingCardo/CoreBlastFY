//
//  RecipeDescriptionCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/27/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class RecipeDescriptionTableViewCell: UITableViewCell {
    static let id = "RecipeDescriptionTableViewCell"
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .black
        label.font = UIFont.makeTitleFont(size: UIDevice.isIpad ? 34 : 24)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        contentView.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipeImage: MealDetails.RecipeDetails.ViewModel.RecipeDetails?) {
        descriptionLabel.text = recipeImage?.title
    }
    
    private func setupViews() {
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = .black
        descriptionLabel.fillSuperview(padding: UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8))
    }
}

extension RecipeDescriptionTableViewCell {
    struct Constants {
        static let descriptionLeading: CGFloat = 8
    }
}
