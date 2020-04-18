//
//  MealPlansOverviewCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class MealPlansOverviewCollectionViewCell: UICollectionViewCell {
    
    static let id = "MealPlansOverviewCollectionViewCell"
    
    func configure(item: MealPlans.GetPlan.ViewModel.PlanOverview) {
        titleLabel.text = item.title.capitalized
        subTitleLabel.text = item.summary.capitalized
        imageView.image = item.image ?? #imageLiteral(resourceName: "6packFY")
    }
    
    let subTitleLabel = UILabel(text: "LIFE HACK", font: .preferredFont(forTextStyle: .title3), numberOfLines: 0)
    let titleLabel = UILabel(text: "Utilizing your Time", font: .preferredFont(forTextStyle: .largeTitle))
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "6packFY")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        createShadowLayer(view: iv)
        return iv
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    var topConstraint: NSLayoutConstraint!
    
    private func labelSetup() {
        subTitleLabel.textColor = .white
        titleLabel.textColor = .white
    }
    
    private func constraintSetup() {
        backgroundColor = .white
        layer.cornerRadius = MealPlansOverviewCollectionViewCell.Dimensions.layerCornerRadius
        clipsToBounds = true
        
        layer.borderColor = UIColor.black.cgColor
        
        let spacerView = UIView()
        spacerView.frame = .init(x: 0, y: 0, width: MealPlansOverviewCollectionViewCell.Dimensions.spacerViewHeight, height: MealPlansOverviewCollectionViewCell.Dimensions.spacerViewHeight)
        spacerView.backgroundColor = .clear
        
        let stackView = VerticalStackView(arrangedSubviews: [
            /*categoryLabel,*/ titleLabel, spacerView, subTitleLabel
        ], spacing: 8)
        imageView.addSubview(stackView)
        stackView.anchor(top: imageView.topAnchor, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: MealPlansOverviewCollectionViewCell.Dimensions.imageViewPadding)
        
        addSubview(imageView)
        imageView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        self.topConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        self.topConstraint.isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelSetup()
        constraintSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension MealPlansOverviewCollectionViewCell {
    struct Dimensions {
        static let imageViewPadding = UIEdgeInsets(top: 32, left: 18, bottom: 24, right: 18)
        static let spacerViewHeight: CGFloat = 240
        static let layerCornerRadius: CGFloat = 16
    }
}
