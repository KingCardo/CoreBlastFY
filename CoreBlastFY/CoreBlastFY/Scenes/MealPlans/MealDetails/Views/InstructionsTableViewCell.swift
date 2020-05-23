//
//  InstructionsCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class InstructionsTableViewCell: UITableViewCell {
    static let id = "InstructionsTableViewCell"
    
    private let titleLabel = UILabel(text: "", font: UIFont.makeAvenirNext(size: UIDevice.isIpad ? 26 : 16)!, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupViews()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
        titleLabel.fillSuperview(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
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
