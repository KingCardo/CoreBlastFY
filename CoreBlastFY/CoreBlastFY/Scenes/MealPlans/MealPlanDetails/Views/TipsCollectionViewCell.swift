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
        label.textAlignment = .left
        label.numberOfLines = 0
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
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    
    private func reset() {
        titleLabel.text = nil
    }
}
