//
//  Program.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 6/30/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class AppFullscreenDescriptionCell: UITableViewCell {
    
    static let id = "AppFullscreenDescriptionCell"
    
    var item: String! {
        didSet {
            let attributedText = NSMutableAttributedString(string: item, attributes: [.foregroundColor: UIColor.black, .font: UIFont.makeTitleFont(size: 24)])
        
             descriptionLabel.attributedText = attributedText
        }
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
