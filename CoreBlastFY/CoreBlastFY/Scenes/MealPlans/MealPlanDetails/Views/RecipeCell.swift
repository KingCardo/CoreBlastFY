//
//  WorkoutCells.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/2/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    static let id = "RecipeCell"
    
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
    
//    lazy var containerView: UIView = {
//        let v = UIView()
//        v.layer.shadowColor = UIColor.black.cgColor
//        v.layer.shadowOpacity = 1
//        v.layer.shadowOffset = .zero//CGSize(width: contentView.frame.size.width, height: 80)
//        v.layer.shadowRadius = CGFloat(15)
//        return v
//    }()
    
    private var mealImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 8
        iv.sizeToFit()
        //iv.createShadow(shadowRadius: CGFloat(15.0), shadowOffset: CGSize(width: CGFloat(15), height: CGFloat(15)), shadowOpacity: 0.7)
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.makeAvenirCondensed(size: 16)
        label.textColor = .white
        label.backgroundColor = .black
        label.sizeToFit()
        return label
    }()
    
   private let mealTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.makeAvenirCondensed(size: 20)
        label.textColor = .white
        label.backgroundColor = .black
        label.sizeToFit()
        return label
    }()
    
    private func configure() {
        setupViews()
    }
    
    // MARK: Setup
    
    private func setupViews() {
//        contentView.addSubview(containerView)
//        containerView.fillSuperview()
        
        contentView.addSubview(mealTypeLabel)
        mealTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        mealTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mealTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mealTypeLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mealTypeLabel.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        contentView.addSubview(mealImageView)
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.width * 0.95).isActive = true
        mealImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.95).isActive = true
        mealImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true

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
