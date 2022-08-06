//
//  ProgressionPicCollectionViewCell.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

final class ProgressionPicsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
    
    //MARK: - Custom Style
    
    enum Style {
        enum Color {
            static let titleFontColor = UIColor.cyan
        }
        enum Font {
            static let labelFont = UIFont.makeAvenirNext(size: 16)
        }
    }
    
    //MARK: - Properties
    
    var progressionPic: ProgressionPic? {
        didSet {
            updateViews()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Style.Font.labelFont
        label.textColor = .white
        return label
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    //MARK: - Private methods
    
    private func updateViews() {
        guard let progressionPic = progressionPic else { return }
        imageView.image = progressionPic.photo
        dateLabel.text = dateFormatter.string(from: progressionPic.timestamp)
    }
    
}

private extension ProgressionPicsCollectionViewCell {
    
    func setup() {
        reset()
        setupImageView()
        setupLabel()
    }
    func reset() {
        imageView.image = nil
    }
    func setupImageView() {
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: ProgressionPicsCollectionViewCell.imageViewInsets.top).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ProgressionPicsCollectionViewCell.imageViewInsets.left).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ProgressionPicsCollectionViewCell.imageViewInsets.bottom).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ProgressionPicsCollectionViewCell.imageViewInsets.right).isActive = true
        imageView.layer.cornerRadius = 20
    }
    
    func setupLabel() {
        imageView.addSubview(dateLabel)
        dateLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ProgressionPicsCollectionViewCell.dateLabelInsets.bottom).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: ProgressionPicsCollectionViewCell.dateLabelInsets.right).isActive = true
    }
}

extension ProgressionPicsCollectionViewCell {
    static let imageViewInsets = UIEdgeInsets(top: 40, left: 16, bottom: -40, right: -16)
    static let dateLabelInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: -30)
}
