//
//  RecipeOptionsCollectionViewCell.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/27/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class RecipeOptionsCollectionViewCell: UICollectionViewCell {
    static let id = "RecipeOptionsCollectionViewCell"
    
    var option1Buttonhandler: (() -> Void)?
    var option2Buttonhandler: (() -> Void)?
    
    // MARK: Views

    private lazy var optionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [option1Button, option2Button])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var option1Button: UIButton = {
        let button = UIButton()
        button.setTitle("Ingredients", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(modeIngredient(_:)), for: .touchDown)
        button.backgroundColor = .goatBlue
        return button
    }()
    
    private lazy var option2Button: UIButton = {
        let button = UIButton()
        button.setTitle("Instructions", for: .normal)
        button.setTitleColor(.goatBlue, for: .normal)
        button.addTarget(self, action: #selector(modeInstruction(_:)), for: .touchDown)
        return button
    }()
    
    @objc func modeIngredient(_ sender: UIButton) {
        option1Buttonhandler?()
        option1Button.backgroundColor = .goatBlue
        option1Button.setTitleColor(.white, for: .normal)
        
        option2Button.backgroundColor = .white
        option2Button.setTitleColor(.goatBlue, for: .normal)
    }
    
    @objc func modeInstruction(_ sender: UIButton) {
        option2Buttonhandler?()
        option1Button.backgroundColor = .white
        option1Button.setTitleColor(.goatBlue, for: .normal)
        
        option2Button.backgroundColor = .goatBlue
        option2Button.setTitleColor(.white, for: .normal)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(optionsStackView)
        optionsStackView.fillSuperview()
    }
    
}
