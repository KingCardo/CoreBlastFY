///
//  Program.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 6/30/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {
    static let id = "AppFullscreenHeaderCell"
    let programCell = MealPlansOverviewCollectionViewCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(programCell)
        contentView.backgroundColor = .black
        programCell.isForDetail = true
        programCell.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
