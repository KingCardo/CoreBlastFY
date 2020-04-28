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
    
     private let titleLabel = UILabel(text: "", font: .preferredFont(forTextStyle: .body), numberOfLines: 1)
    
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
        titleLabel.centerYInSuperview()
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
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
