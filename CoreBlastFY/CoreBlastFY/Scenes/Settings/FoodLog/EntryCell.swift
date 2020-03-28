//
//  EntryCell.swift
//  Journal
//
//  Created by Riccardo Washington on 5/22/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    
    enum Dimensions {
        static let titleLabelLeadingAnchor: CGFloat = 16
        static let timeStampLabelTrailingAnchor: CGFloat = -16
        static let titleLabelHeight: CGFloat = 80
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setup() {
        backgroundColor = .black
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.titleLabelLeadingAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Dimensions.titleLabelHeight).isActive = true
        
        addSubview(timeStampLabel)
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Dimensions.timeStampLabelTrailingAnchor).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: Dimensions.titleLabelHeight).isActive = true
    }
    
    func updateViews() {
        if let entry = entry {
            titleLabel.text = entry.title
            timeStampLabel.text = dateFormatter.string(from: entry.timeStamp) 
        }
    }
    
    //MARK: Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - UI Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.makeAvenirNext(size: 24)
        label.textColor = .white
        return label
    }()
    
    private lazy var timeStampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}
