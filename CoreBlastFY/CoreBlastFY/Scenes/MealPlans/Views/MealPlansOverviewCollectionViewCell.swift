//
//  MealPlansOverviewCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class MealPlansOverviewCollectionViewCell: UICollectionViewCell {
    
    var item: MealPlans.GetPlan.ViewModel.PlanOverview! {
        didSet {
            configure(item: item)
            backgroundColor = .white

//            handleImageView()
//            categoryLabel.text = item.category.uppercased()
//            titleLabel.text = item.title.capitalized
//
//            descriptionLabel.text = item.description
//
//
//            backgroundColor = item.backgroundColor
//            backgroundView?.backgroundColor = item.backgroundColor

        }
    }
    
    private func configure(item: MealPlans.GetPlan.ViewModel.PlanOverview) {
        titleLabel.text = item.title.capitalized
        categoryLabel.text = item.summary.capitalized
        imageView.image = #imageLiteral(resourceName: "6packFY")
    }
//
//    private func handleImageView() {
//       // if item.imageURL == nil {
////            ProgramController.shared.downloadAssetUrl(ref: ProgramController.shared.storageRef.child("images/\(item.image)")) { (url) in
////                self.item.imageURL = url
//               // self.imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "whiteBG"))
//    //        }
//      //  } else {
//            //imageView.sd_setImage(with: item.imageURL, placeholderImage: #imageLiteral(resourceName: "whiteBG"))
//       // }
//    }
//
    let categoryLabel = UILabel(text: "LIFE HACK", font: .systemFont(ofSize: 22, weight: .medium))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 30, weight: .heavy))
//
//
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "6packFY")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        createShadowLayer(view: iv)
        return iv
    }()
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 14, weight: .medium), numberOfLines: 3)
//
    var topConstraint: NSLayoutConstraint!
//
    func labelSetup() {
        categoryLabel.textColor = .white
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
//
    func constraintSetup() {
        backgroundColor = .white
        layer.cornerRadius = 16
       // imageView.layer.masksToBounds = true
        clipsToBounds = true

        layer.borderColor = UIColor.black.cgColor
       // createShadowLayer(view: imageView)
        let spacerView = UIView()
        spacerView.frame = .init(x: 0, y: 0, width: 240, height: 240)
        spacerView.backgroundColor = .clear

        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, spacerView, descriptionLabel
            ], spacing: 8)
        imageView.addSubview(stackView)
        stackView.anchor(top: imageView.topAnchor, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 32, left: 18, bottom: 24, right: 18))

        addSubview(imageView)
        imageView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        self.topConstraint = imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        self.topConstraint.isActive = true
    }
    static let id = "MealPlansOverviewCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)

        labelSetup()
        constraintSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }}

