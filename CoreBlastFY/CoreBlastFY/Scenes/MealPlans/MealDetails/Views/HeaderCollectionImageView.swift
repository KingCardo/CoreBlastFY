//
//  HeaderCollectionReusableView.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class HeaderCollectionImageView: UICollectionViewCell {
    static let id = "HeaderCollectionImageView"
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "mp2image"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview(padding: UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipeImage: MealDetails.RecipeDetails.ViewModel.RecipeDetails?) {
        imageView.image = recipeImage?.image
    }
        
}
