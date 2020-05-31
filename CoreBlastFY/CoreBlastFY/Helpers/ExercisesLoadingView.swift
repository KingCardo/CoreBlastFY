//
//  ExercisesLoadingView.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/30/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class ExercisesLoadingView: UIView {

    let label = UILabel(text: "Workout section will be available here when programs finish downloading!", font: .makeTitleFontDB(size: UIDevice.isIpad ? 35: 25), numberOfLines: 0)
    
    init(text: String = "Workout section will be available here when programs finish downloading!") {
        super.init(frame: .zero)
        backgroundColor = .black
        label.text = text
        label.textColor = .white
        addSubview(label)
        label.fillSuperview(padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
