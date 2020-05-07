//
//  InstructionsCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class InstructionsCollectionViewCell: UICollectionViewCell {
    static let id = "InstructionsCollectionViewCell"
    
    private let titleLabel = UILabel(text: "", font: UIFont.makeAvenirNext(size: 14)!, numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.fillSuperview(padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
//        titleLabel.centerYInSuperview()
//        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        titleLabel.text = nil
    }
    
    func configure(with recipe: String?) {
        titleLabel.text = recipe
    }
    
}
