//
//  DetailHeaderView.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/9/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    private var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = image
        return iv
    }()
    
    private func setup() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
}
