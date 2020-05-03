//
//  WorkoutCells.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/2/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.name
        mealTypeLabel.text = recipe.mealType.rawValue
        mealImageView.image = recipe.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 8
        iv.sizeToFit()
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = Fonts.mainFont
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
   private let mealTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = Fonts.subFont
        label.textColor = .goatBlack
        label.sizeToFit()
        return label
    }()
    
    private func configure() {
        setupViews()
    }
    
    // MARK: Setup
    
    private func setupViews() {
        contentView.addSubview(mealTypeLabel)
        mealTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        mealTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mealTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mealTypeLabel.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mealTypeLabel.leadingAnchor).isActive = true
        
        contentView.addSubview(mealImageView)
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mealImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mealImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    
    private func reset() {
        mealImageView.image = nil
        titleLabel.text = nil
        mealTypeLabel.text = nil
    }
    
}