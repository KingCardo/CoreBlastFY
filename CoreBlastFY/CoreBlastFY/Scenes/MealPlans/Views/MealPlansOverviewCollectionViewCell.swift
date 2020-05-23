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
    var isForDetail = false {
        didSet {
            imageViewSetup()
        }
    }
    
    func configure(item: MealPlanDetail.FetchDetails.ViewModel.DisplayMealPlanDetails) {
        imageView.image = item.planImage ?? #imageLiteral(resourceName: "6packFY")
    }
    
    func configure(item: MealPlans.GetPlan.ViewModel.PlanOverview) {
        titleLabel.text = item.title.capitalized
        subTitleLabel.text = item.summary.capitalized
        imageView.image = item.image ?? #imageLiteral(resourceName: "6packFY")
    }
    
    let subTitleLabel = UILabel(text: "", font: UIFont.makeAvenirNext(size: UIDevice.isIpad ? 26 : 16)!, numberOfLines: 2)
    let titleLabel = UILabel(text: "", font: UIFont.makeTitleFont(size: UIDevice.isIpad ? 28 : 18), numberOfLines: 1)
    
     var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "6packFY")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        //iv.createShadowLayer()
        return iv
    }()

    private func labelSetup() {
        subTitleLabel.textColor = .white
        titleLabel.textColor = .white
    }
    
    private func constraintSetup() {
        layer.cornerRadius = MealPlansOverviewCollectionViewCell.Dimensions.layerCornerRadius
        clipsToBounds = true
        
        layer.borderColor = UIColor.black.cgColor
        
        let verticalStack = VerticalStackView(arrangedSubviews: [titleLabel, subTitleLabel], spacing: 6)
        verticalStack.distribution = .fillProportionally

        contentView.addSubview(verticalStack)
        contentView.backgroundColor = .black
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MealPlansOverviewCollectionViewCell.Dimensions.insets.top).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MealPlansOverviewCollectionViewCell.Dimensions.insets.top).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: MealPlansOverviewCollectionViewCell.Dimensions.insets.bottom).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func imageViewSetup() {
        addSubview(imageView)
        imageView.fillSuperview()
        
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
        static let insets = UIEdgeInsets(top: 12, left: 8, bottom: 6, right: 0)
        static let layerCornerRadius: CGFloat = 16
    }
}
