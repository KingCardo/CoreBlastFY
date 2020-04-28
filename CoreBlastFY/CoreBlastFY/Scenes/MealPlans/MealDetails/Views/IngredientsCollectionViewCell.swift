//
//  IngredientsCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    static let id = "IngredientsCollectionViewCell"
    
    private let titleLabel = UILabel(text: "", font: .preferredFont(forTextStyle: .body), numberOfLines: 1)
    private let amountLabel = UILabel(text: "", font: .preferredFont(forTextStyle: .title3), numberOfLines: 1)
        
    static let leadingAnchor: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupViews()
    }
    
    private func setupViews() {
        amountLabel.textColor = .goatBlue
        contentView.addSubview(titleLabel)
        titleLabel.centerYInSuperview()
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: IngredientsCollectionViewCell.leadingAnchor).isActive = true
        contentView.addSubview(amountLabel)
        amountLabel.centerYInSuperview()
        amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -IngredientsCollectionViewCell.leadingAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        titleLabel.text = nil
        amountLabel.text = nil
    }
    
    func configure(with recipe: MealDetails.RecipeDetails.ViewModel.Ingredients?) {
        titleLabel.text = recipe?.name
        amountLabel.text = recipe?.amount
    }
}
