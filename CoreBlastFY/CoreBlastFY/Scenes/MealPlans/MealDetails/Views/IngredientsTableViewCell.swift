//
//  IngredientsCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    static let id = "IngredientsTableViewCell"
    
    private let titleLabel = UILabel(text: "", font: UIFont.makeAvenirNext(size: 16)!, numberOfLines: 1)
    private let amountLabel = UILabel(text: "", font: UIFont.makeAvenirNext(size: 16)!, numberOfLines: 1)
        
    static let leadingAnchor: CGFloat = 8
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupViews()
    }
    
    private func setupViews() {
        amountLabel.textColor = .gray
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
        amountLabel.backgroundColor = .black
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.centerYInSuperview()
        //titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: IngredientsTableViewCell.leadingAnchor).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        contentView.addSubview(amountLabel)
        amountLabel.centerYInSuperview()
        amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -IngredientsTableViewCell.leadingAnchor).isActive = true
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
