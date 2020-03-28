//
//  StackElementViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/24/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class StackElementViewController: UIViewController {
    
    var headerLabel = UILabel()
    var bodyLabel = UILabel()
    
    var headerString: String? {
        didSet {
            configureView()
        }
    }
    
    var bodyString: String? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        headerLabel.text = headerString
        bodyLabel.text = bodyString
    }
    
    func addLabelToView() {
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(bodyLabel)
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        let font = UIFont.init(name: "Avenir Next", size: 13)
        
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        bodyLabel.font =  fontMetrics.scaledFont(for: font!)
        bodyLabel.textColor = .white
        bodyLabel.adjustsFontForContentSizeCategory = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabelToView()
        view.backgroundColor = .black
    }
    
}


