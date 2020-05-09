//
//  TipsCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/7/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    static let id = "TipsCollectionViewCell"
    
    func configure(with tip: String) {
        titleLabel.text = tip
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.makeAvenirCondensed(size: 20)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private let tapMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap me for more info!"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.makeAvenirCondensed(size: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private func configure() {
        setupViews()
    }
    
    // MARK: Setup
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.fillSuperview()
        titleLabel.addSubview(tapMoreLabel)
        tapMoreLabel.centerXInSuperview()
        tapMoreLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -16).isActive = true 
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    
    private func reset() {
        titleLabel.text = nil
    }
}
